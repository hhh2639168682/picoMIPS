//-----------------------------------------------------
// File Name   : alu.sv
// Function    : ALU module for picoMIPS
// Version: 1,  only 8 funcs
// Author:  hh2u22
// Last rev. 10/04/23
//-----------------------------------------------------

`include "alucodes.sv"  
module alu #(parameter n =8) (
   input logic  signed [n-1:0] a, b, // ALU operands
   input logic [3:0]func, // ALU function code
   output logic [n-1:0] result // ALU result
);       
//------------- code starts here ---------

// create an n-bit adder 
// and then build the ALU around the adder
logic signed [n-1:0] ar,b1; // add signals
logic [15:0] m1;// mul signals

/*always_comb
begin
   if(func==`RSUB)
      b1 = ~b + 1'b1; // 2's complement subtrahend
   else b1 = b;

   ar = a+b1; // n-bit adder
end // always_comb
*/
 

always_comb
begin
    m1='0;
	 ar= '0;
   if(func == `RMUL)
	
      m1 = a * b; // 2's complement subtrahend
		
   //else 
	   //m1 = 0;

	if (func == `RSUB) begin
      //b1= ~b + 1'b1;
      ar = b-a;
   end
      //else begin
      //b1=b;
      //ar = a +b1;
     // end
      
   

	if(func == `RADD)	

   ar = a + b; 
	 
	 //else 
	//ar = 0;
end // always_comb




//assign m1 = a * b;
//assign ar = a + b;
 
// create the ALU, use signal ar in arithmetic operations
always_comb
begin
  //default output values; prevent latches
  //flag = 1'b0;  
  result = a; // default
  
  case(func)
     `RADD  : begin
	     result = ar; // arithmetic addition
		 
		end
    `RMUL  : begin
	     result = m1[14:7]; // arithmetic mul
		  
		end   
	`RSUB :begin
      result = ar;
   end	
  default : result = a;
     
   endcase

 end //always_comb

endmodule //end of module ALU

