//------------------------------------
// File Name   : cpu.sv
// Function    : picoMIPS CPU top level encapsulating module, version 2
// Author      : tjk
// Ver 2 :  PC , prog memory, regs, ALU and decoder, no RAM
// Last revised: 27 Oct 2012
//------------------------------------

`include "alucodes.sv"
module cpu #( parameter n = 8) // data bus width
(input logic clk,  
  input reset, // master reset
  input logic [9:0] SW,
  output logic[n-1:0] outport // need an output port, tentatively this will be the ALU output
);       

// declarations of local signals that connect CPU modules
// ALU
logic [3:0] ALUfunc; // ALU function
//logic [3:0] flags; // ALU flags, routed to decoder
logic imm; // immediate operand signal
logic signed  [n-1:0] Alua, Alub; // output from imm MUX
logic ipc;
//
// registers
logic [n-1:0] Rdata1, Rdata2, Wdata; // Register data
logic w; // register write control
//
// Program Counter 
parameter Psize = 6; // up to 64 instructions
logic PCincr ;// program counter control
logic [Psize-1 : 0]ProgAddress;
// Program Memory
parameter Isize = 20; // Isize - instruction width
logic [Isize-1:0] I; // I - instruction code

//------------- code starts here ---------
// module instantiations
pc  #(.Psize(Psize)) progCounter (.clk(clk),.reset(reset),
        .PCincr(PCincr),
        .Branchaddr(I[Psize-1:0]), 
        .PCout(ProgAddress) );

prog #(.Psize(Psize),.Isize(Isize)) 
      progMemory (.address(ProgAddress),.I(I));

decoder  D (.opcode(I[Isize-1:Isize-4]),
            .PCincr(PCincr),
            .inflag(I[7]), 
            .swhold(SW[8]),
				.holdflag(I[7]),
            // ALU flags
				.ipc(ipc),
		  .ALUfunc(ALUfunc),.imm(imm),.w(w));

regs   #(.n(n))  gpr(.clk(clk),.w(w),
        .Wdata(Wdata),
		.Raddr2(I[Isize-5:Isize-8]),  // reg %d number
		.Raddr1(I[Isize-9:Isize-12]), // reg %s number
      .Rdata1(Rdata1),.Rdata2(Rdata2));

alu    #(.n(n))  alu(.a(Alua),.b(Alub),
       .func(ALUfunc),
       .result(Wdata)); // ALU result -> destination reg

// create MUX for immediate operand
assign Alua = (ipc ? SW[7:0] : Rdata1);
assign Alub = (imm ? I[7:0] : Rdata2);


// connect ALU result to outport
assign outport = Wdata;

endmodule