//---------------------------------------------------------
// File Name   : decoder.sv
// Function    : picoMIPS instruction decoder 
// Author: hh2u22
// ver 2:  //  ADD, ADDI, mul, hold
// Last revised: 22/04/2023
//---------------------------------------------------------

`include "alucodes.sv"
`include "opcodes.sv"
//---------------------------------------------------------
module decoder
( input logic [3:0] opcode, // top 6 bits of instruction
//input [3:0] flags, // ALU flags
// output signals
//    PC control
 input logic swhold,  inflag,
  
 input logic holdflag,
 
 output logic PCincr,
//    ALU control
output logic  [3:0]ALUfunc, 
// imm mux control
output logic imm,
// input port control
output logic ipc,
//  register file control
output logic w
  );
   
//------------- code starts here ---------
// instruction decoder
// temp variable to control conditional branching



always_comb 
begin
  // set default output signal values for NOP instruction
   PCincr = 1'b1; // PC increments by default
   ALUfunc = `RADD; 
   imm=1'b0;
   w=1'b0; 
   ipc = 1'b0;
	
   unique case(opcode)
     `ADD: begin // register-register
	        w = 1'b1;// write result to dest register
			  ipc = inflag;
			  ALUfunc = `RADD;
	      end

     `ADDI: begin // register-immediate
	        w = 1'b1; // write result to dest register
		     imm = 1'b1; // set ctrl signal for imm operand MUX
			  ALUfunc =`RADD;
	      end

	  `MUL:begin
		     w = 1'b1;
			 ipc = 0;
			  //imm = 1'b1;
			  ALUfunc =`RMUL;
			  end

	  `SUB:	begin
		     w = 1'b1;
			 ipc = inflag;
			 ALUfunc =`RSUB;
	  end	  
	  
	 `HOLD:begin
		     if(swhold != holdflag)
			  begin
		        PCincr = 1'b0;
			  end
		   end
				  
  endcase // opcode
  

end // always_comb


endmodule //module decoder --------------------------------