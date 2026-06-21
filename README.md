Booth Multiplier (8-bit Signed) in SystemVerilog

Overview:
Implements an 8-bit signed multiplier using Booth's Algorithm in Verilog HDL (Range -127 to 127).
The design follows a classic RTL architecture by separating the system into a Control Path (FSM) and a Data Path. The multiplier supports signed two's-complement operands and generates a 16-bit signed product.
A self-checking testbench is included to verify functionality across all possible 8-bit input combinations. 

Architecture:

Control Path:
The control unit is implemented as a Finite State Machine (FSM).
Main responsibilities:
Load multiplicand (M)
Load multiplier (Q)
Initialize accumulator (A)
Evaluate Booth encoding bits {Q0, Q-1}
Select ADD or SUB operation
Perform arithmetic shift
Control iteration counter
Generate completion signal (done)

Data Path:
The datapath contains:
+, Accumulator Register (A)
+, Multiplier Register (Q)
+, Booth Bit Register (Q-1)
+, Multiplicand Register (M)
+, Arithmetic Logic Unit (ALU)
+, Iteration Counter

The ALU performs:
Signed Addition
Signed Subtraction
Arithmetic right shifting is implemented across: (A, Q, Q-1) to preserve sign extension during multiplication.

Verification:
A self-checking testbench compares the DUT output against the reference result:
expected = $signed(M) * $signed(Q);
For each completed multiplication:
if(data_out !== expected)
errors are recorded automatically into:
error_log.txt
The simulation iterates through all 8-bit operand combinations and reports the total number of mismatches.

Tools: 
SystemVerilog
Xilinx Vivado Simulato
