//-----------------------------------------------------
// File Name : regstest.sv
// Function : testbench for pMIPS 32 x n registers, %0 == 0
// Version 1 : code template for Cyclone  MLAB 
//             and true dual port sync RAM
// Author: tjk
// Last rev. 25 Oct 2012
//-----------------------------------------------------
module regstest;

parameter n = 8;

logic clk, w;
logic [n-1:0] Wdata;
logic [2:0] Raddr1, Raddr2;
logic [n-1:0] Rdata1, Rdata2;

//regs  #(.n(n)) r(.*);

regs #(.n(8)) gpr (.clk(clk),.w(w),
							 .Wdata(Wdata), // write ALU result to Rd
							 .Raddr1(Raddr1),  // reg %d number
							 .Raddr2(Raddr2), // reg %s number
							 .Rdata1(Rdata1),.Rdata2(Rdata2)); 

initial
begin
  clk =  0;
  #5ns  forever #5ns clk = ~clk;
end

initial
begin
        w = 1;
    	Raddr2 = 3'b001; Wdata = 8'd10 ;
		#10	Raddr2 = 3'b010; Wdata = 8'd11 ;
		#10	Raddr2 = 3'b011; Wdata = 8'd12 ;
		#10	Raddr2 = 3'b100; Wdata = 8'd13 ;
		#20
		#10 w =0 ;
    #10	Raddr1 = 3'b001; Raddr2 = 3'b001;
		#10	Raddr1 = 3'b010; Raddr2 = 3'b010;
		#10	Raddr1 = 3'b011; Raddr2 = 3'b011;
		#10	Raddr1 = 3'b100; Raddr2 = 3'b100;
		
end

	

endmodule // module regstest