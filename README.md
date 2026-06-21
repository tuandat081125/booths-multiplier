Booth Multiplier (8-bit Signed) in SystemVerilog

Overview:
Implements an 8-bit signed multiplier using Booth's Algorithm in Verilog HDL (Range -127 to 127).
The design follows a classic RTL architecture by separating the system into a Control Path (FSM) and a Data Path. The multiplier supports signed two's-complement operands and generates a 16-bit signed product.
A self-checking testbench is included to verify functionality across all possible 8-bit input combinations. 

Architecture:

Control Path:<br>
The control unit is implemented as a Finite State Machine (FSM).<br>
Main responsibilities:<br>
Load multiplicand (M),
Load multiplier (Q),
Initialize accumulator (A),
Evaluate Booth encoding bits {Q0, Q-1},
Select ADD or SUB operation,
Perform arithmetic shift,
Control iteration counter,
Generate completion signal (done)

State	Function:<br>
S0	| Reset / Initialize<br>
S1	| Load Multiplicand<br>
S2	| Load Multiplier<br>
S3	| Booth Decision<br>
S4	| Add Multiplicand<br>
S5	| Subtract Multiplicand<br>
S6	| Arithmetic Shift<br>
S7	| Loop Control<br>
S8	| Done<br>

Data Path:
The datapath contains:
+, Accumulator Register (A)<br>
+, Multiplier Register (Q)<br>
+, Booth Bit Register (Q-1)<br>
+, Multiplicand Register (M)<br>
+, Arithmetic Logic Unit (ALU)<br>
+, Iteration Counter<br>

The ALU performs:<br>
Signed Addition<br>
Signed Subtraction<br>
Arithmetic right shifting is implemented across: (A, Q, Q-1) to preserve sign extension during multiplication.<br>

Verification:<br>
A self-checking testbench compares the DUT output against the reference result: expected = $signed(M) * $signed(Q)<br>
For each completed multiplication: if(data_out !== expected)<br>
errors are recorded automatically into: error_log.txt<br>
The simulation iterates through all 8-bit operand combinations and reports the total number of mismatches.

Tools: 
SystemVerilog, Xilinx Vivado Simulation
