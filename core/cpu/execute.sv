`default_nettype none
`include "include.vh"

module execute (
	input wire clk,    // Clock
	input wire rst_n,  // Asynchronous reset active low
	input wire [31:0] pc,

	input wire [31:0] rs1,
	input wire [31:0] rs2,
	input wire [31:0] imm,
	input wire [6:0] opcode,
	input wire [2:0] op_ctrl,
	input wire op_switch,
	input wire op_imm,
	input wire [4:0] shamt,
	input wire [31:0] address,
	input wire m_write,
	input wire m_read,
	input wire reset_memory, 
	output reg [31:0] wdata,
	output wire exe_fin,
	output reg b_en,
	output reg jmp_addr,


     // AXI4-lite master memory interface
	     // address write channel
	     output reg                      axi_awvalid = 0,
	     input wire                       axi_awready,
	     output wire [31:0]               axi_awaddr,
	     output wire [2:0]                 axi_awprot,
	     // data write channel
	     output reg                      axi_wvalid = 0,
	     input wire                       axi_wready,
	     output reg [31:0]                axi_wdata,
	     output reg [3:0]                 axi_wstrb,
	     // response channel
	     input wire                       axi_bvalid,
	     output reg                      axi_bready = 0,
	     input wire [1:0]                 axi_bresp,
	     // address read channel
	     output reg                      axi_arvalid = 0,
	     input reg                       axi_arready,
	     output wire [31:0]                axi_araddr,
	     output reg [2:0]                 axi_arprot,
	     // read data channel
	     input wire                       axi_rvalid,
	     output reg                       axi_rready = 0,
	     input wire [31:0]                axi_rdata,
	     input wire [1:0]                 axi_rresp

);

wire [31:0 ] read_data;
assign read_data =	op_ctrl == 3'b000 ? {{24{axi_rdata[7]}},axi_rdata[7:0]}:
				 	op_ctrl == 3'b001 ? {{16{axi_rdata[15]}},axi_rdata[15:0]}:
				 	op_ctrl == 3'b100 ? {24'b0,axi_rdata[7:0]}:
				 	op_ctrl == 3'b101 ? {16'b0,axi_rdata[15:0]}:
				 	axi_rdata;


always @(posedge clk) begin

	if(~rst_n)begin
		wdata <= 0;
	end else begin
		case (opcode)
			`OP_LUI: wdata <= imm;
			`OP_ALU: wdata <= alu_result; 
			`OP_ALUI: wdata <= alu_result; 
			`OP_LOAD: wdata <= read_data;
			default : wdata <= 32'b0;
		endcase
	end
end




always @(posedge clk)begin
	if(~rst_n) begin
		b_en <= 0;
	end else begin
		case (op_ctrl)
			3'b000: b_en <=  rs1 == rs2;
			3'b001: b_en <= rs1 != rs2;
			3'b100: b_en <= $signed(rs1) < $signed(rs2);
			3'b101: b_en <= $signed(rs1) >= $signed(rs2);
			3'b110: b_en <= $unsigned(rs1) < $unsigned(rs2);
			3'b111: b_en <= $unsigned(rs1) >= $unsigned(rs2);
			default : /* default */;
		endcase
	end
end

assign exe_fin = (opcode == `OP_ALU 	|| 
				 opcode == `OP_ALUI) ? 1'b1:
			 	(opcode == `OP_LOAD) ? axi_rvalid :
			 	(opcode == `OP_STORE)? axi_wvalid :0;



// alu
wire [31:0] op1,op2;
wire is_shamt;
assign is_shamt = opcode == `OP_ALUI && (op_ctrl == `ALU_SLL || op_ctrl == `ALU_SRX); 
assign op1 = rs1;
// assign op2 = op_imm ? imm : rs2;
assign op2 = opcode == `OP_ALUI ? (is_shamt?{27'b0,shamt}:imm) : rs2;

	wire [31:0] alu_result;
alu alu (
	.op1       (op1       ),
	.op2       (op2       ),
	.op_ctrl   (op_ctrl   ),
	.op_switch (op_switch ),
	.alu_result(alu_result)
);


// memory
reg done;
always @(posedge clk)begin
	if(reset_memory) begin
		done <= 0;
	end
end



// read
always @(posedge clk)begin
	if(~rst_n)begin
		axi_arvalid <= 0;
		axi_rready  <= 0;
	end else begin 
		if(opcode == `OP_STORE && ~axi_arvalid && ~done) begin
			axi_arready <= 1'b1;
			axi_rready <= 1'b1;
		end

		if(axi_arready & axi_arvalid)begin
			axi_arready <= 0;
			done <= 1;
		end

		if(axi_rready & axi_rvalid)begin
			axi_rready <= 0;
			wdata <= axi_rdata;
		end
	end

end

assign 		axi_araddr = $signed(imm) + rs1;


//write
always @(posedge clk)begin
	if(~rst_n)begin
		axi_awvalid <= 0;
		axi_wvalid <= 0;
	end else begin
		if(opcode == `OP_STORE && ~axi_awvalid && ~done)begin
			axi_awvalid <= 1'b1;
			axi_wvalid <= 1'b1;
			axi_wstrb <= (op_ctrl == 3'b000 ? 4'b0001:
						  op_ctrl == 3'b001 ? 4'b0011:
						  4'b1111);
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

assign 		axi_awaddr = $signed(imm) + rs1;
assign      axi_awprot = 3'b0;

always @(posedge clk )begin
	if(~rst_n) begin
		jmp_addr <= 0;
	end else begin
		jmp_addr <= pc + $signed(imm);
	end
end


endmodule

`default_nettype wire


