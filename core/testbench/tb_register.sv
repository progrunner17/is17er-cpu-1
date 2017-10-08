
`timescale 1ns/1ps

module tb_register (); /* this is automatically generated */


	// (*NOTE*) replace reset, clock, others
	logic clk;
	logic        rst_n = 0;
	logic  [4:0] waddr;
	logic        we;
	logic [31:0] wdata;
	logic  [4:0] rs1addr;
	logic [31:0] rs1;
	logic  [4:0] rs2addr;
	logic [31:0] rs2;
	
	logic [31:0] test0,test1,test2,test3;
	

	register inst_register (
		.clk    (clk    ),
		.rst_n  (rst_n  ),
		.waddr  (waddr  ),
		.we     (we     ),
		.wdata  (wdata  ),
		.rs1addr(rs1addr),
		.rs1    (rs1    ),
		.rs2addr(rs2addr),
		.rs2    (rs2    ),
		.test0  (test0  ),
		.test1  (test1  ),
		.test2  (test2  ),
		.test3  (test3  )
	);
	// clock
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	initial begin
	    rst_n = 0;
		#10;
		rst_n = 1;
		#5;
		waddr = 5'd1;
		wdata = 32'd1;
		we  = 0;
		#10;
		we = 1;
		#2;
		waddr = 0;
		#10;
		waddr = 2;
		wdata = 3;
		rs1addr = 1;
		rs2addr = 2;
		#20;



		$finish;
	end

endmodule
