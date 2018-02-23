`default_nettype none

`include "./include.vh"


module register
(clk,rst_n,d_en,xwe,rd_addr,wdata,rs1_addr,E_rs1,rs2_addr,E_rs2);

input wire clk;
input wire rst_n;
input wire d_en;
input wire xwe;
input wire  [4:0] rd_addr;
input wire  [31:0] wdata;
input wire  [4:0] rs1_addr;
output reg [31:0] E_rs1 = 32'h0000_0000;
input wire  [4:0] rs2_addr;
output reg [31:0] E_rs2 = 32'h0000_0000;



reg [31:0] x [31:0] ;
integer i;
initial for(i=0;i<32;i=i+1)x[i] = 0;


// read control (decode stage)
always  @(posedge clk)begin
	if(~rst_n)begin
		E_rs1 <= 0;
		E_rs2 <= 0;
	end else if(d_en)begin
		E_rs1 <= x[rs1_addr];
		E_rs2 <= x[rs2_addr];
	end
end

// write control (write back stage)
always @(posedge clk)begin
	if(xwe && (rd_addr != 5'b00000))begin
		x[rd_addr] <= wdata;
	end
end


endmodule

`default_nettype wire

