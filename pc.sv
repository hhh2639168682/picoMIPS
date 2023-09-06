//-----------------------------------------------------
// File Name : pc.sv
// Function : picoMIPS Program Counter
// functions: increment, absolute and relative branches
// Author: hh2u22
// Last rev. 23/04/2023
//-----------------------------------------------------
module pc #(parameter Psize = 6) // up to 64 instructions
(input logic clk, reset, PCincr,
 input logic [Psize-1:0] Branchaddr,
 output logic [Psize-1 : 0]PCout
);

//------------- code starts here---------
logic[Psize-1:0] Rbranch; // temp variable for addition operand
always_comb
  if (PCincr)
       Rbranch = { {(Psize-1){1'b0}}, 1'b1};//000001
  else Rbranch =  Branchaddr;


always_ff @ ( posedge clk or posedge reset) // async reset
  if (reset) // sync reset
     PCout <= {Psize{1'b0}};//00000
  else if (PCincr) // increment or relative branch    pcincr=1/pcrelbranch=1
     PCout <= PCout + Rbranch; // 1 adder does both
  else // absolute branch
     PCout <= Branchaddr;
	 
endmodule // module pc
