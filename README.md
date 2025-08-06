# MIPS-VHDL
A simplified MIPS CPU implementation in VHDL

## Contains
	1.  ALU 
	2.  Register file 
	3.  Data memory (array of 32 bits)
	4.  Instruction memory (array of 32 bits)
	5.  Control Unit
	6.  ALU Control Unit
	7.  Program Counter (PC)
	8.  2-to-1 5-bit Multiplexer
	9.  Sign Extension Unit (16-to-32)
	10. 2-to-1 32-bit Multiplexers
	11. Left Shift Unit(32-bit)
	12. Adder(32-bit)

## 	Important information
	The Instruction memory, Data memory, has 16 locations (32 bits for each one).
	The Program counter increases its value by one after each instruction.
	The supported instructions are: add,sub,and,slt,lw.
	The testbench files are premade examples for each unit
	
	If you want to change the instructions you must replace the instructions that 
	are already in Instruction memory with yours.
	
 ## How to run
 -Open the VHDL program in a simulation tool like Modelsim  
 -Load the VHDL files (the testbench can be skipped)  
 -Compile the Design  
 -Load the MIPS testbench  
 -Add all signals  
 -Run the simulation
