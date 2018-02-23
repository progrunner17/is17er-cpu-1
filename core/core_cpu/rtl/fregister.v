`default_nettype none
`include "./include.vh"

module fregister
(clk,rst_n,d_en,fwe,rd_addr,wdata,rs1_addr,E_frs1,rs2_addr,E_frs2);

input wire clk;
input wire rst_n;
input wire  d_en;
input wire  fwe;
input wire  [4:0] rd_addr;
input wire  [31:0] wdata;
input wire  [4:0] rs1_addr;
output reg [31:0] E_frs1 = 32'h0000_0000;
input wire  [4:0] rs2_addr;
output reg [31:0] E_frs2 = 32'h0000_0000;
reg [31:0] f [31:0];


initial begin
 f[0 ] = 32'h0000_0000;
 f[1 ] = 32'h0000_0000;
 f[2 ] = 32'h0000_0000;
 f[3 ] = 32'h0000_0000;
 f[4 ] = 32'h0000_0000;
 f[5 ] = 32'h0000_0000;
 f[6 ] = 32'h0000_0000;
 f[7 ] = 32'h0000_0000;
 f[8 ] = 32'h0000_0000;
 f[9 ] = 32'h0000_0000;
 f[10] = 32'h0000_0000;
 f[11] = 32'h3F80_0000;		//1.0
 f[12] = 32'h4000_0000;		//2.0
 f[13] = 32'h4080_0000;		//4.0
 f[14] = 32'h4120_0000;		//10.0
 f[15] = 32'h4170_0000;		//15.0
 f[16] = 32'h41A0_0000;		//20.0
 f[17] = 32'h4300_0000;		//128.0
 f[18] = 32'h4348_0000;		//200.0
 f[19] = 32'h437F_0000;		//255.0
 f[20] = 32'h4454_8000;		//850.0
 f[21] = 32'h3DCC_CCCD;		//0.100
 f[22] = 32'h3E4C_CCCD;		//0.200
 f[23] = 32'h3A83_126F;		//0.001
 f[24] = 32'h3BA3_D70A;		//0.005
 f[25] = 32'h3E19_999A;		//0.150
 f[26] = 32'h3E80_0000;		//0.250
 f[27] = 32'h3F00_0000;		//0.500
 f[28] = 32'h4049_0FDB;		//pi
 f[29] = 32'h4118_C9EB;		//30.0 /pi
 f[30] = 32'h0000_0000;
 f[31] = 32'h0000_0000;
end




// read control(decode stage)
always  @(posedge clk)begin
	if(~rst_n)begin
		E_frs1 <= 0;
		E_frs2 <= 0;
	end else if(d_en)begin
		E_frs1 <= f[rs1_addr];
		E_frs2 <= f[rs2_addr];
	end
end



wire inside_we;
assign inside_we = ( (rd_addr!= 0 && rd_addr < 11)  || rd_addr > 29) && fwe;

// write control(write back stage)
always @(posedge clk)begin
	if(inside_we)begin
		f[rd_addr] <= wdata;
	end
end


endmodule


// module check_addr(
// 	input wire we,
// 	input [4:0] wire addr ,
// 	output wire inside_we);
// assign inside_we = ( (addr!= 0 && addr < 11)  || addr > 29) && we;
// endmodule

`default_nettype wire
