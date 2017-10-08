`default_nettype none

`include "include.vh"


module register (
	input wire clk,
	input wire rst_n,

	input wire  [4:0] waddr,
	input wire we,
	input wire  [31:0] wdata,

	input wire  [4:0] rs1_addr,
	output reg [31:0] rs1,

	input wire  [4:0] rs2_addr,
	output reg [31:0] rs2
	
	// output wire [31:0]test0,
	// output wire [31:0]test1,
	// output wire [31:0]test2,
	// output wire [31:0]test3

	// forwarding
	// input wire fw1,
	// input wire fw2,
	// input wire [31:0] fwdata,

	// pc 
	// input wire pc_we,
	// input wire pc_wdata,
	// output reg [31:0] pc
	);

	reg [31:0] register[31:0];
	always @(posedge clk)begin
		if(~rst_n)begin
			register[0] <= 32'h0;
			register[1] <= 32'h0;
			register[2] <= 32'h0;
			register[3] <= 32'h0;
			register[4] <= 32'h0;
			register[5] <= 32'h0;
			register[6] <= 32'h0;
			register[7] <= 32'h0;
			register[8] <= 32'h0;
			register[9] <= 32'h0;
			register[10] <= 32'h0;
			register[11] <= 32'h0;
			register[12] <= 32'h0;
			register[13] <= 32'h0;
			register[14] <= 32'h0;
			register[15] <= 32'h0;
			register[16] <= 32'h0;
			register[17] <= 32'h0;
			register[18] <= 32'h0;
			register[19] <= 32'h0;
			register[20] <= 32'h0;
			register[21] <= 32'h0;
			register[22] <= 32'h0;
			register[23] <= 32'h0;
			register[24] <= 32'h0;
			register[25] <= 32'h0;
			register[26] <= 32'h0;
			register[27] <= 32'h0;
			register[28] <= 32'h0;
			register[29] <= 32'h0;
			register[30] <= 32'h0;
			register[31] <= 32'h0;
		end else if(we && (waddr != 0))begin
			register[waddr] <= wdata;
		end
	end

always  @(posedge clk)begin
	if(~rst_n)begin 
			rs1 <= 0;
			rs2 <= 0;
	end else begin
	rs1 <= register[rs1_addr];
	rs2 <= register[rs2_addr];
	end
end

// test
// assign test0 = register[0];
// assign test1 = register[1];
// assign test2 = register[2];
// assign test3 = register[3];

endmodule // register

`default_nettype wire

