`default_nettype none

`include "include.vh"


module register (
	input wire clk,
	input wire rst_n,

	input wire [4:0] waddr,
	input wire we,
	input wire [31:0] wdata,

	input wire [4:0] rs1addr,
	output reg [31:0] rs1,

	input wire [4:0] rs2addr,
	output reg [31:0] rs2,

	input wire pc_we,
	input wire pc_wdata,
	output reg [31:0] pc
	);
generate
	reg [31:0] register[31:0];
	always @(posedge clk)begin
		if(~rst_n)begin
			for (int i = 0; i < 32; i=i+1) begin
				register[i] <= 32'h0;
			end
		end else if(we && (~|waddr))begin
			register[waddr] <= wdata;
		end
	end
endgenerate

always  @(posedge clk)begin
	rs1 <= register[rs1addr];
	rs2 <= register[rs2addr];
end

endmodule // register

`default_nettype wire

