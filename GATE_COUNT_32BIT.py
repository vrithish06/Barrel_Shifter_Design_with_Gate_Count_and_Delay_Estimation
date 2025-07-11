import re

def parse_verilog(file_path):
    """
    Parses the Verilog file to count the number of muxes in each stage and estimate metrics.
    """
    try:
        with open(file_path, 'r') as file:
            verilog_code = file.read()
    except FileNotFoundError:
        raise FileNotFoundError(f"File not found: {file_path}")
    
    # Stage definitions for 32-bit barrel shifter
    stages = {
        1: r'// 16-bit shift',  # Marker for stage 1
        2: r'// 8-bit shift',   # Marker for stage 2
        3: r'// 4-bit shift',   # Marker for stage 3
        4: r'// 2-bit shift',   # Marker for stage 4
        5: r'// 1-bit shift',   # Marker for stage 5
    }

    # Find the start of each stage
    stage_positions = {}
    for stage, marker in stages.items():
        match = re.search(marker, verilog_code)
        if match:
            stage_positions[stage] = match.start()
        else:
            raise ValueError(f"Marker for stage {stage} not found in the Verilog file.")

    # Sort stages by position
    sorted_stages = sorted(stage_positions.items(), key=lambda x: x[1])

    # Count mux2 instances for each stage
    stage_mux_counts = {}
    for i in range(len(sorted_stages)):
        stage_start = sorted_stages[i][1]
        stage_end = sorted_stages[i + 1][1] if i + 1 < len(sorted_stages) else len(verilog_code)
        stage_code = verilog_code[stage_start:stage_end]
        stage_mux_counts[sorted_stages[i][0]] = len(re.findall(r'\bmux2\b', stage_code))
    
    # Metrics
    gates_per_mux2 = 3  # Assume 3 gates per mux2 (AND, OR, XORs)
    delay_per_stage = 1  # Each stage has 1 unit delay
    
    # Calculate total gates and delays
    total_muxes = sum(stage_mux_counts.values())
    total_gates = total_muxes * gates_per_mux2
    total_delay = len(stage_mux_counts) * delay_per_stage  # Delay is the number of stages
    
    return {
        'stage_mux_counts': stage_mux_counts,
        'total_muxes': total_muxes,
        'total_gates': total_gates,
        'total_delay': total_delay
    }

def main():
    # File path to the Verilog design
    file_path = "barrel_shifter_32bit.v"
    
    try:
        # Parse and calculate metrics
        metrics = parse_verilog(file_path)
        
        # Print the results
        print("Stage-wise mux2 Counts:")
        for stage, count in metrics['stage_mux_counts'].items():
            print(f"  Stage {stage}: {count} mux2 instances")
        print(f"Total Number of mux2 Instances: {metrics['total_muxes']}")
        print(f"Total Number of Gates: {metrics['total_gates']}")
        print(f"Estimated Total Delay: {metrics['total_delay']*3} units")
    
    except (FileNotFoundError, ValueError) as e:
        print(f"Error: {e}")

if _name_ == "_main_":
    main()
