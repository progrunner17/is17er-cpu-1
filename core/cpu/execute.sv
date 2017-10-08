`default_nettype none
`include "include.vh"

module execute (
	input wire clk,    // Clock
	input wire rst_n,  // Asynchronous reset active low
	input wire [31:0] pc,

	input wire [6:0] opcode,
	input wire [2:0] op_ctrl,
	input wire op_switch,

// alu
	input wire [31:0] rs1,
	input wire [31:0] rs2,
	input wire [31:0] imm,	
	// input wire [4:0] shamt,

// branch
	output reg b_en,
	output reg jmp_addr,


// memory
	input wire mem_lock,


	output reg [31:0] rd,


     // AXI4-lite master memory interface
	     // address write channel
	     output reg                      axi_awvalid,
	     input wire                       axi_awready,
	     output reg [31:0]               axi_awaddr,
	     output wire [2:0]                 axi_awprot,
	     // data write channel
	     output reg                      axi_wvalid,
	     input wire                       axi_wready,
	     output reg [31:0]                axi_wdata,
	     output reg [3:0]                 axi_wstrb,
	     // response channel
	     input wire                       axi_bvalid,
	     output reg                      axi_bready,
	     input wire [1:0]                 axi_bresp,
	     // address read channel
	     output reg                      axi_arvalid,
	     input reg                       axi_arready,
	     output reg [31:0]                axi_araddr,
	     output wire [2:0]                 axi_arprot,
	     // read data channel
	     input wire                       axi_rvalid,
	     output reg                       axi_rready ,
	     // input wire [31:0]                axi_rdata,
	     input wire [1:0]                 axi_rresp

);





// alu
wire [31:0] op2;
assign op2 = 	(opcode == `OP_ALUI) ? rs2:
				(opcode == `OP_ALUI) ? imm:
				32'b0;
wire [31:0] alu_result;

alu alu (
	.op1       (rs1       ),
	.op2       (op2       ),
	.op_ctrl   (op_ctrl   ),
	.op_switch (op_switch ),
	.alu_result(alu_result)
);

//all

always @(posedge clk)begin
	if(~rst_n) begin
		rd <= 0;
	end else begin
		case (opcode)
			`OP_LUI : rd <= imm;
			`OP_JAL : rd <= pc + 4;
			`OP_JALR : rd <= pc + 4;
			`OP_ALU : rd <= alu_result;
			`OP_ALUI: rd <= alu_result;
			default : rd <= 32'h0;
		endcase
	end
end


// jmp_addr 
always @(posedge clk) begin
	if(~rst_n)begin
		jmp_addr <= 0;
	end else begin
		if(opcode == `OP_JAL)begin
			jmp_addr <= pc + $signed(imm);
		end else if(opcode == `OP_JALR) begin
			jmp_addr <= rs1 + $signed(imm);
		end else if( opcode == `OP_BRANCH) begin
			jmp_addr <= pc + $signed(imm);
	end 
end
end


// branch
always @(posedge clk)begin
	if(~rst_n) begin
		b_en <= 0;
	end else begin
		case (op_ctrl)
			`B_EQ	: b_en <= (rs1 == rs2);
			`B_NE	: b_en <= ~(rs1 == rs2);
			`B_LT 	: b_en <= $signed(rs1) < $signed(rs2);
			`B_GE 	: b_en <= $signed(rs1) >= $signed(rs2);
			`B_LTU	: b_en <= $unsigned(rs1) < $unsigned(rs2);
			`B_GEU	: b_en <= $unsigned(rs1) >= $unsigned(rs2);
			default : b_en <= 0;
		endcase
	end
end





// read
always @(posedge clk)begin
	if(~rst_n)begin
		axi_arvalid <= 0;
		axi_araddr <= 0;

		axi_rready  <= 0;
	end else begin 
		if(opcode == `OP_STORE && ~mem_lock ) begin
			axi_arready <= 1'b1;
			axi_rready <= 1'b1;
			axi_araddr  <= $signed(imm) + $signed(rs1) ;
		end

		if(axi_arready & axi_arvalid)begin
			axi_arready <= 0;
		end

		if(axi_rready & axi_rvalid)begin
			axi_rready <= 0;
		end
	end
end

assign axi_arprot = 3'b0;


//write
always @(posedge clk)begin
	if(~rst_n)begin
		axi_awvalid <= 0;
		axi_wvalid <= 0;
		axi_awaddr <= 0;
		axi_wdata <= 0;
		axi_wstrb <= 0;
		axi_bready <= 0;
	end else begin
		if(opcode == `OP_STORE && ~mem_lock)begin
			axi_awvalid <= 1'b1;
			axi_wvalid <= 1'b1;
			axi_wdata <= rs2;
			axi_awaddr <= $signed(imm) + rs1;
			axi_wstrb <= (op_ctrl == `STORE_BYTE ? 4'b0001:
						  op_ctrl == `STORE_HALF ? 4'b0011:
						  op_ctrl == `STORE_WORD ? 4'b1111:
						  4'b0000);
		end

		if(axi_awvalid && axi_awready)begin
			axi_awvalid <= 0;
		end

		if(axi_wvalid && axi_wready)begin
			axi_wvalid <= 0;
		end

		if(axi_wvalid && axi_wready) begin
   			axi_wvalid <= 0;
		    axi_bready <= 1;
		end

  		if(axi_bready && axi_bvalid) begin
    		axi_bready <= 0;
  		end
	end
end

assign      axi_awprot = 3'b0;

endmodule

`default_nettype wire


