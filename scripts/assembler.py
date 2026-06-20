import sys  # <--- THIS IS WHAT IS MISSING
# Define your CPU Opcode Mapping (3 bits each)
OPCODES = {
    "nop":    "0",
    "load":   "1",
    "mov":    "2",
    "add":    "3",
    "b":      "8",
    "bz":     "9",
    "bnz":    "a",
    "return": "b"
}
REGISTERS = {
    "mem":     "0",
    "regA":    "1",
    "regB":    "2",
    "regC":    "3",
    "regD":    "4",
    "IntAdd":  "5",
    "IntSaved":"6",
    "InDa0":   "8",
    "InDa1":   "9"
}
def assemble_line(line, line_num):
    line = line.split('#')[0].split('//')[0]
    print (f"Debug [Line {line_num}]: {line}")
    if not line:
        return None  # Empty line or pure comment
    tokens = line.split()
    cmd = tokens[0]
    if cmd == "nop":
        hex_string = "00000"
        return hex_string
    else: 
        data_int = int(tokens[3], 10)
        print (f"int num: {data_int}")
        data_8bit = data_int & 0xFF
        print (f"int8bit num: {data_8bit}")
        data_hex_str = format(data_8bit, '02X')
        print (f"int8bit num: {data_hex_str}")
#        hex_string =OPCODES[cmd]+REGISTERS[tokens[1]]+REGISTERS[tokens[2]]+tokens[3]
        hex_string =OPCODES[cmd]+REGISTERS[tokens[1]]+REGISTERS[tokens[2]]+data_hex_str
        print (f"hex_string: {hex_string}")
        return hex_string
  
def main():
    if len(sys.argv) < 3:
        print('Error Please use: "assembler.py <input_file> <output_file>"')
        sys.exit(1)
        
    # Assign the arguments to variables
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    
    hex_output = []
    
    # Read and parse assembly file
    try:
        with open(input_file, 'r') as f:
            for idx, line in enumerate(f, start=1):
                hex_val = assemble_line(line, idx)
                if hex_val:
                    hex_output.append(hex_val)
    except FileNotFoundError:
        print(f"Error: Input file '{input_file}' not found.")
        sys.exit(1)

    # Write out the final file
    with open(output_file, 'w') as f:
        for hex_val in hex_output:
            f.write(f"{hex_val}\n")
 
    print(f"END Script")
 
if __name__ == "__main__":
    main()