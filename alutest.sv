`include "alucodes.sv"   
module alutest;   
parameter n =8; // data bus width   
logic [n-1:0] a, b; // ALU input operands   
logic  [3:0]func; // ALU func code     
logic [n-1:0] result; // ALU result 
alu #(.n(n)) alu1 (.a(a), .b(b), .func(func), .result(result) );  // create alu object 
//------------- code starts here --------- 
	initial    
		begin  a= 100;  b= 200;        // test all funcRons      
		#10 func = `RADD; // result = a+b   
		#10 func = `RMUL ; // result = a*b 
		#10 func = `RSUB ;
		
		end //initial 
endmodule //end of alutest