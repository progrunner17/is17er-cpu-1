`default_nettype none
`include "./include.vh"

module float (
	input wire clk,    // Clock
	input wire rst_n,  // Asynchronous reset active low


	input wire ef_en,
	input wire [31:0] f_rs1,
	input wire [31:0] f_frs1,
	input wire [31:0] f_frs2,
	input wire [2:0] f_funct3,
	input wire [4:0] f_funct5,
	output wire [31:0] fpdata,
	output wire  fp_valid,


	// AXI4-stream fadd op1 interface
	output reg [31:0] fadd_a_tdata = 0,
	input  wire fadd_a_tready,
	output reg fadd_a_tvalid = 0,
	// AXI4-stream fadd op2 interface
	output reg [31:0] fadd_b_tdata = 0,
	input  wire fadd_b_tready,
	output reg fadd_b_tvalid = 0,
	// AXI4-stream fadd ctrl interface
	output reg [7:0] fadd_operation_tdata = 0,
	input  wire fadd_operation_tready,
	output reg fadd_operation_tvalid = 0,
	// AXI4-stream fadd result interface
	input wire [31:0] fadd_r_tdata,
	input wire fadd_r_tvalid,
	output reg fadd_r_tready  = 0,


	// AXI4-stream fmul op1 interface
	output reg [31:0] fmul_a_tdata = 0,
	input  wire fmul_a_tready,
	output reg fmul_a_tvalid = 0,
	// AXI4-stream fmul op2 interface
	output reg [31:0] fmul_b_tdata = 0,
	input  wire fmul_b_tready,
	output reg fmul_b_tvalid = 0,
	// AXI4-stream fmul result interface
	input wire [31:0] fmul_r_tdata,
	input wire fmul_r_tvalid,
	output reg fmul_r_tready  = 0,

	// AXI4-stream fdiv op1 interface
	output reg [31:0] fdiv_a_tdata = 0,
	input  wire fdiv_a_tready,
	output reg fdiv_a_tvalid = 0,
	// AXI4-stream fdiv op2 interface
	output reg [31:0] fdiv_b_tdata = 0,
	input  wire fdiv_b_tready,
	output reg fdiv_b_tvalid = 0,
	// AXI4-stream fdiv result interface
	input wire [31:0] fdiv_r_tdata,
	input wire fdiv_r_tvalid,
	output reg fdiv_r_tready  = 0,
	// AXI4-stream fsqrt op1 interface
	output reg [31:0] fsqrt_tdata = 0,
	input  wire fsqrt_tready,
	output reg fsqrt_tvalid = 0,
	// AXI4-stream fsqrt result interface
	input wire [31:0] fsqrt_r_tdata,
	input wire fsqrt_r_tvalid,
	output reg fsqrt_r_tready  = 0,
	// AXI4-stream fcmp op1 interface
	output reg [31:0] fcmp_a_tdata = 0,
	input  wire fcmp_a_tready,
	output reg fcmp_a_tvalid = 0,
	// AXI4-stream fcmp op2 interface
	output reg [31:0] fcmp_b_tdata = 0,
	input  wire fcmp_b_tready,
	output reg fcmp_b_tvalid = 0,
	// AXI4-stream fcmp operation interface
	output reg [7:0] fcmp_operation_tdata = 0,
	input  wire fcmp_operation_tready,
	output reg fcmp_operation_tvalid = 0,
	// AXI4-stream fcmp result interface
	input wire [7:0] fcmp_r_tdata,
	input wire fcmp_r_tvalid,
	output reg fcmp_r_tready  = 0,
	// AXI4-stream ftoi op interface
	output reg [31:0] ftoi_tdata = 0,
	input  wire ftoi_tready,
	output reg ftoi_tvalid = 0,
	// AXI4-stream ftoi result interface
	input wire [31:0] ftoi_r_tdata,
	input wire ftoi_r_tvalid,
	output reg ftoi_r_tready  = 0,
	// AXI4-stream floor op interface
	output reg [31:0] floor_tdata = 0,
	input  wire floor_tready,
	output reg floor_tvalid = 0,
	// AXI4-stream floor result interface
	input wire [31:0] floor_r_tdata,
	input wire floor_r_tvalid,
	output reg floor_r_tready  = 0,
	// AXI4-stream itof op1 interface
	output reg [31:0] itof_tdata = 0,
	input  wire itof_tready,
	output reg itof_tvalid = 0,
	// AXI4-stream itof result interface
	input wire [31:0] itof_r_tdata,
	input wire itof_r_tvalid,
	output reg itof_r_tready = 0

);

assign fp_valid = (fadd_r_tready && fadd_r_tvalid)||(fmul_r_tready && fmul_r_tvalid)||(fdiv_r_tready && fdiv_r_tvalid)||(fsqrt_r_tready && fsqrt_r_tvalid)||(ftoi_r_tready && ftoi_r_tvalid)||(floor_r_tready && floor_r_tvalid)||(itof_r_tready && itof_r_tvalid)||(fcmp_r_tready && fcmp_r_tvalid);
assign fpdata = (fadd_r_tready && fadd_r_tvalid)? fadd_r_tdata:
				(fmul_r_tready && fmul_r_tvalid)? fmul_r_tdata:
				(fdiv_r_tready && fdiv_r_tvalid)? fdiv_r_tdata:
				(fsqrt_r_tready && fsqrt_r_tvalid)? fsqrt_r_tdata:
				(ftoi_r_tready && ftoi_r_tvalid)? ftoi_r_tdata:
				(floor_r_tready && floor_r_tvalid)? floor_r_tdata:
				(itof_r_tready && itof_r_tvalid)? itof_r_tdata:
				(fcmp_r_tready && fcmp_r_tvalid)? {24'h0,fcmp_r_tdata} : 32'h0;

wire f5_is_fadd;
wire f5_is_fsub;
wire f5_is_fmul;
wire f5_is_fdiv;
wire f5_is_fsqrt;
wire f5_is_ftoi;
wire f5_is_floor;
wire f5_is_itof;
wire f5_is_fcmp;

wire [7:0] operation;


assign f5_is_fadd = ef_en && (f_funct5 == `F5_FADD);
assign f5_is_fsub = ef_en && (f_funct5 == `F5_FSUB);
assign f5_is_fmul = ef_en && (f_funct5 == `F5_FMUL);
assign f5_is_fdiv = ef_en && (f_funct5 == `F5_FDIV);
assign f5_is_fsqrt = ef_en && (f_funct5 == `F5_FSQRT);
assign f5_is_ftoi = ef_en && (f_funct5 == `F5_FTOI) && f_funct3 == `F3_RNE;
assign f5_is_floor = ef_en && (f_funct5 == `F5_FTOI) && f_funct3 == `F3_RDN;
assign f5_is_itof = ef_en && (f_funct5 == `F5_ITOF);
assign f5_is_fcmp = ef_en && (f_funct5 == `F5_FCMP);

assign operation = (f5_is_fadd) ? 8'b00000000 :(f5_is_fsub) ? 8'b00000001 :
				   (f5_is_fcmp && (f_funct3 ==`F3_FEQ) ) ? 8'b00010100 :
				   (f5_is_fcmp && (f_funct3 ==`F3_FLT) ) ? 8'b00001100 :
				   (f5_is_fcmp && (f_funct3 ==`F3_FLE) ) ? 8'b00011100 :
				   8'h00;

// fadd
always @(posedge clk) begin
	if(~rst_n || (fadd_r_tready && fadd_r_tvalid) ) begin
		 fadd_r_tready <= 1'b0;
	end else if( f5_is_fadd || f5_is_fsub ) begin
		 fadd_r_tready <= 1'b1;
	end
end

always @(posedge clk) begin
	if(~rst_n || (fadd_a_tready && fadd_a_tvalid )) begin
		 fadd_a_tvalid <= 1'b0;
	end else if(f5_is_fadd || f5_is_fsub) begin
		fadd_a_tvalid <= 1'b1;
	end
end

always @(posedge clk) begin
	if(~rst_n || (fadd_b_tready && fadd_b_tvalid )) begin
		 fadd_b_tvalid <= 1'b0;
	end else if(f5_is_fadd || f5_is_fsub) begin
		fadd_b_tvalid <= 1'b1;
	end
end

always @(posedge clk) begin
	if(~rst_n || (fadd_operation_tready && fadd_operation_tvalid )) begin
		 fadd_operation_tvalid <= 1'b0;
	end else if(f5_is_fadd || f5_is_fsub) begin
		fadd_operation_tvalid <= 1'b1;
	end
end

always @(posedge clk) begin
	if(f5_is_fadd || f5_is_fsub) begin
		 fadd_a_tdata <= f_frs1;
		 fadd_b_tdata <= f_frs2;
		 fadd_operation_tdata <= operation;
	end
end

// fmul
always @(posedge clk) begin
	if(~rst_n || (fmul_r_tready && fmul_r_tvalid) ) begin
		 fmul_r_tready <= 1'b0;
	end else if( f5_is_fmul ) begin
		 fmul_r_tready <= 1'b1;
	end
end

always @(posedge clk) begin
	if(~rst_n || (fmul_a_tready && fmul_a_tvalid )) begin
		 fmul_a_tvalid <= 1'b0;
	end else if(f5_is_fmul) begin
		fmul_a_tvalid <= 1'b1;
	end
end

always @(posedge clk) begin
	if(~rst_n || (fmul_b_tready && fmul_b_tvalid )) begin
		 fmul_b_tvalid <= 1'b0;
	end else if(f5_is_fmul) begin
		fmul_b_tvalid <= 1'b1;
	end
end

always @(posedge clk) begin
	if(f5_is_fmul) begin
		 fmul_a_tdata <= f_frs1;
		 fmul_b_tdata <= f_frs2;
	end
end

// fdiv
always @(posedge clk) begin
	if(~rst_n || (fdiv_r_tready && fdiv_r_tvalid) ) begin
		 fdiv_r_tready <= 1'b0;
	end else if( f5_is_fdiv ) begin
		 fdiv_r_tready <= 1'b1;
	end
end

always @(posedge clk) begin
	if(~rst_n || (fdiv_a_tready && fdiv_a_tvalid )) begin
		 fdiv_a_tvalid <= 1'b0;
	end else if(f5_is_fdiv) begin
		fdiv_a_tvalid <= 1'b1;
	end
end

always @(posedge clk) begin
	if(~rst_n || (fdiv_b_tready && fdiv_b_tvalid )) begin
		 fdiv_b_tvalid <= 1'b0;
	end else if(f5_is_fdiv) begin
		fdiv_b_tvalid <= 1'b1;
	end
end

always @(posedge clk) begin
	if(f5_is_fdiv) begin
		 fdiv_a_tdata <= f_frs1;
		 fdiv_b_tdata <= f_frs2;
	end
end

// fsqrt
always @(posedge clk) begin
	if(~rst_n || (fsqrt_r_tready && fsqrt_r_tvalid) ) begin
		 fsqrt_r_tready <= 1'b0;
	end else if( f5_is_fsqrt ) begin
		 fsqrt_r_tready <= 1'b1;
	end
end

always @(posedge clk) begin
	if(~rst_n || (fsqrt_tready && fsqrt_tvalid )) begin
		 fsqrt_tvalid <= 1'b0;
	end else if(f5_is_fsqrt) begin
		fsqrt_tvalid <= 1'b1;
	end
end

always @(posedge clk) begin
	if(f5_is_fsqrt) begin
		 fsqrt_tdata <= f_frs1;
	end
end

// ftoi
always @(posedge clk) begin
	if(~rst_n || (ftoi_r_tready && ftoi_r_tvalid) ) begin
		 ftoi_r_tready <= 1'b0;
	end else if( f5_is_ftoi ) begin
		 ftoi_r_tready <= 1'b1;
	end
end

always @(posedge clk) begin
	if(~rst_n || (ftoi_tready && ftoi_tvalid )) begin
		 ftoi_tvalid <= 1'b0;
	end else if(f5_is_ftoi) begin
		ftoi_tvalid <= 1'b1;
	end
end

always @(posedge clk) begin
	if(f5_is_ftoi) begin
		 ftoi_tdata <= f_frs1;
	end
end


always @(posedge clk) begin
	if(~rst_n || (floor_r_tready && floor_r_tvalid) ) begin
		 floor_r_tready <= 1'b0;
	end else if( f5_is_floor ) begin
		 floor_r_tready <= 1'b1;
	end
end

always @(posedge clk) begin
	if(~rst_n || (floor_tready && floor_tvalid )) begin
		 floor_tvalid <= 1'b0;
	end else if(f5_is_floor) begin
		floor_tvalid <= 1'b1;
	end
end

always @(posedge clk) begin
	if(f5_is_floor) begin
		 floor_tdata <= f_frs1;
	end
end

// itof
always @(posedge clk) begin
	if(~rst_n || (itof_r_tready && itof_r_tvalid) ) begin
		 itof_r_tready <= 1'b0;
	end else if( f5_is_itof ) begin
		 itof_r_tready <= 1'b1;
	end
end

always @(posedge clk) begin
	if(~rst_n || (itof_tready && itof_tvalid )) begin
		 itof_tvalid <= 1'b0;
	end else if(f5_is_itof) begin
		itof_tvalid <= 1'b1;
	end
end

always @(posedge clk) begin
	if(f5_is_itof) begin
		 itof_tdata <= f_rs1;
	end
end


// fcmp

always @(posedge clk) begin
	if(~rst_n || (fcmp_r_tready && fcmp_r_tvalid) ) begin
		 fcmp_r_tready <= 1'b0;
	end else if( f5_is_fcmp ) begin
		 fcmp_r_tready <= 1'b1;
	end
end

always @(posedge clk) begin
	if(~rst_n || (fcmp_a_tready && fcmp_a_tvalid )) begin
		 fcmp_a_tvalid <= 1'b0;
	end else if(f5_is_fcmp) begin
		fcmp_a_tvalid <= 1'b1;
	end
end

always @(posedge clk) begin
	if(~rst_n || (fcmp_b_tready && fcmp_b_tvalid )) begin
		 fcmp_b_tvalid <= 1'b0;
	end else if(f5_is_fcmp) begin
		fcmp_b_tvalid <= 1'b1;
	end
end

always @(posedge clk) begin
	if(~rst_n || (fcmp_operation_tready && fcmp_operation_tvalid )) begin
		 fcmp_operation_tvalid <= 1'b0;
	end else if(f5_is_fcmp) begin
		fcmp_operation_tvalid <= 1'b1;
	end
end

always @(posedge clk) begin
	if(f5_is_fcmp) begin
		 fcmp_a_tdata <= f_frs1;
		 fcmp_b_tdata <= f_frs2;
		 fcmp_operation_tdata <= operation;
	end
end


endmodule




module axi_stream_floor (
	input wire clk,
	input wire rst_n,
	input wire [31:0] floor_tdata,
	output  wire floor_tready,
	input wire floor_tvalid,
	// AXI4-stream floor result interface
	output reg [31:0] floor_r_tdata,
	output reg floor_r_tvalid = 1'b0,
	input wire floor_r_tready
);

assign floor_tready = 1;

wire [7:0] e;
assign e = floor_tdata[30:23];
wire [22:0] m;
assign m = floor_tdata[22:0];
wire s;
assign s = floor_tdata[31];
wire [31:0] dout_p;
wire [31:0] dout ;
wire [22:0] tmp;
assign tmp = (e < 140 && e >= 127) ? (m<<(e-127)) : 0;
wire sticky ;

assign sticky = e<127 || (e<140 && (|tmp));

assign  dout_p = ($unsigned(e) > 8'd157) ? 32'h7FFF_FFFF:
	    		 ($unsigned(e) <  8'd127) ? 32'h0000_0000:
				 ({2'b01,m,7'd0} >> (8'd157 - $unsigned(e)));
assign	dout = ~floor_tdata[31] ?  dout_p :
				sticky ?  ~dout_p : ~dout_p + 1;


always @(posedge clk) begin
	if(~rst_n) begin
		 floor_r_tdata <= 32'h0;
		 floor_r_tvalid <= 1'b0;
	end else begin
		 floor_r_tdata <=  dout;
		 floor_r_tvalid <= floor_tvalid;
	end
end

endmodule

`default_nettype wire