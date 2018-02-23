`default_nettype none

`include "./include.vh"

module execute #(
	parameter INSTR_ADDR_WIDTH = 14
)
(clk,rst_n,e_en,E_pc,W_pc_incr,
 E_opcode,E_funct5,E_funct3,
 E_rs1,E_rs2,E_frs1,E_frs2,E_imm,
 W_jmp_en,W_jmp_addr,
 E_rd_addr,E_write_flags,
 W_rd_addr,W_write_flags,W_rd,
AXI_AWREADY,AXI_AWVALID,AXI_AWADDR,AXI_AWPROT,
AXI_WREADY, AXI_WVALID, AXI_WDATA, AXI_WSTRB,
AXI_BREADY, AXI_BVALID, //AXI_BRESP,
AXI_ARREADY,AXI_ARVALID,AXI_ARADDR,AXI_ARPROT,
AXI_RREADY, AXI_RVALID, //AXI_RDATA, //AXI_RRESP,
UART_INPUT_TREADY ,UART_INPUT_TVALID,
UART_OUTPUT_TREADY,UART_OUTPUT_TVALID,UART_OUTPUT_TDATA
);
	input  wire                  clk          ; // Clock
	input  wire                  rst_n        ; // Asynchronous reset active low
	input  wire                  e_en         ;
	// pc
	input  wire [INSTR_ADDR_WIDTH-1:0] E_pc         ;
	output reg  [INSTR_ADDR_WIDTH-1:0] W_pc_incr      = 'h0;

	input  wire [           4:0] E_opcode     ;
	input  wire [           4:0] E_funct5     ;
	input  wire [           2:0] E_funct3     ;
	// operands
	input  wire [          31:0] E_rs1        ;
	input  wire [          31:0] E_rs2        ;
	input  wire [          31:0] E_frs1       ;
	input  wire [          31:0] E_frs2       ;
	input  wire [          31:0] E_imm        ;
	// branch
	output reg                   W_jmp_en     ;
	output reg  [INSTR_ADDR_WIDTH-1:0] W_jmp_addr   ;
	//write back control
	input  wire [           4:0] E_rd_addr    ;
	input  wire [ `WF_WIDTH-1:0] E_write_flags;
	output reg  [           4:0] W_rd_addr      = 5'b00000;
	output reg  [ `WF_WIDTH-1:0] W_write_flags  = 6'b000000;
	output reg  [          31:0] W_rd           = 32'h0000_0000;
	// AXI4-lite master memory interface
	// address write channel
	output reg                   AXI_AWVALID  ;
	input  wire                  AXI_AWREADY  ;
	output reg  [          31:0] AXI_AWADDR     =32'h0000_0000;
	output wire [           2:0] AXI_AWPROT   ;
	// data write channel
	output reg                   AXI_WVALID     = 1'b0;
	input  wire                  AXI_WREADY   ;
	output reg  [          31:0] AXI_WDATA      = 32'h0000_0000;
	output reg  [           3:0] AXI_WSTRB      = 4'b0000;
	// response channel
	input  wire                  AXI_BVALID   ;
	output reg                   AXI_BREADY     = 1'b0;
	// input wire [1:0]                 AXI_BRESP;
	// address read channel
	output reg                   AXI_ARVALID    = 1'b0;
	input  wire                  AXI_ARREADY  ;
	output reg  [          31:0] AXI_ARADDR     = 1'b0;
	output wire [           2:0] AXI_ARPROT   ;
	// read data channel
	input  wire                  AXI_RVALID   ;
	output reg                   AXI_RREADY     = 1'b0;
	// input wire [31:0]                AXI_RDATA;
	// input wire [1:0]                 AXI_RRESP
	// AXI4-stream slave memory interface
	// input  wire [           7:0] UART_INPUT_TDATA ;
	output reg                   UART_INPUT_TREADY = 1'b0;
	input  wire                  UART_INPUT_TVALID;
	output reg  [           7:0] UART_OUTPUT_TDATA = 8'h00;
	output reg                   UART_OUTPUT_TVALID = 1'b0;
	input  wire                  UART_OUTPUT_TREADY;

// pc

	wire [INSTR_ADDR_WIDTH-1:0] pc_incr ;
	assign pc_incr = E_pc + 1;
	always @(posedge clk) begin
		if(~rst_n) begin
			W_pc_incr <= 0;
		end else if(e_en) begin
			W_pc_incr <= pc_incr;
		end
	end

// alu
	wire [31:0] op2;
	assign op2 = (E_opcode == `OP_ALU) ? E_rs2: E_imm ;

	wire [31:0] alu_result;
	alu alu (.op1(E_rs1),.op2(op2),.funct3(E_funct3),.is_sub_sra(E_funct5[3]  && E_opcode == `OP_ALU),.alu_result(alu_result));

//fsgnj
	wire [31:0] fsgnj;
	wire        fsgn ;
	assign fsgn = 	(E_funct3 == `F3_FSGNJN) ?  ~E_frs2[31]:
					(E_funct3 ==  `F3_FSGNJX) ? (E_frs1[31] ^E_frs2[31]):
					 E_frs2[31];//3'b000
	assign fsgnj = {fsgn,E_frs1[30:0]};


// rd
	wire [31:0] frd;
	assign frd =
		(E_funct5 == `F5_FTOX)? E_frs1:
		(E_funct5 == `F5_XTOF)? E_rs1 :
		fsgnj;

	always @(posedge clk) begin

		if(~rst_n) begin
			W_rd          <= 32'h0000_0000;
			W_rd_addr     <= 5'b00000;
			W_write_flags <= `WF_WIDTH'b000000;
		end else if(e_en)begin

			case (E_opcode)
				`OP_LUI: W_rd <= E_imm;
				`OP_AUIPC: W_rd <= E_imm + E_pc;
				`OP_JAL: W_rd <= pc_incr;
				`OP_JALR: W_rd <= pc_incr;
				`OP_ALU: W_rd <= alu_result;
				`OP_ALUI: W_rd <= alu_result;
				`OP_FP: W_rd <= frd;
				default : W_rd <= 0;
			endcase

			W_rd_addr     <= E_rd_addr;
			W_write_flags <= E_write_flags;

		end
	end



// jmp control
	wire [31:0] jmp_addr;
	assign jmp_addr =
		(E_opcode == `OP_JALR) ? ($signed(E_imm) + $unsigned(E_rs1)):
		($signed(E_imm) + $unsigned(E_pc));
	wire jmp_en;
	assign jmp_en =
				(E_opcode == `OP_JAL || E_opcode == `OP_JALR||
				(E_opcode == `OP_BRANCH  &&
				 	((E_funct3 == `B_EQ  && (E_rs1 == E_rs2))||
					 (E_funct3 == `B_NE  && (E_rs1 != E_rs2))||
					 (E_funct3 == `B_LT  && ($signed(E_rs1) < $signed(E_rs2)))||
					 (E_funct3 == `B_GE  && ($signed(E_rs1) >= $signed(E_rs2)))||
					 (E_funct3 == `B_LTU && ($unsigned(E_rs1) < $unsigned(E_rs2)))||
					 (E_funct3 == `B_GEU && ($unsigned(E_rs1) >= $unsigned(E_rs2))))));

	always @(posedge clk) begin
		if(~rst_n) begin
			W_jmp_en   <= 0;
			W_jmp_addr <= 0;
		end else if(e_en) begin
			W_jmp_en   <= jmp_en;
			W_jmp_addr <= jmp_addr[INSTR_ADDR_WIDTH-1:0];
		end
	end

	wire [31:0] mem_addr;
	assign mem_addr = ($signed(E_rs1) + $signed(E_imm)) << 2; //NOTE:word addressing


// load
	wire load_en;
	assign load_en = e_en && (E_opcode == `OP_LOAD || E_opcode == `OP_LOAD_FP);
	always @(posedge clk)begin
		if(~rst_n)begin
			AXI_ARVALID <= 1'b0;
			AXI_ARADDR  <= 32'h0000_0000;
			AXI_RREADY  <= 1'b0;
		end else begin
			if(load_en) begin
				AXI_ARVALID <= 1'b1;
				AXI_RREADY  <= 1'b1;
				AXI_ARADDR  <= mem_addr;
			end
			if(AXI_ARREADY & AXI_ARVALID)AXI_ARVALID <= 1'b0;
			if(AXI_RREADY & AXI_RVALID)AXI_RREADY <= 1'b0;
		end
	end
	assign AXI_ARPROT = 3'b0;

//store
	wire [31:0] write_data;
	assign write_data = (E_opcode == `OP_STORE) ? E_rs2: E_frs2;

	wire store_en;
	assign store_en = e_en && (E_opcode == `OP_STORE || E_opcode == `OP_STORE_FP);

	wire [3:0] wstrb;
	assign wstrb = (E_funct3 == `STORE_BYTE) ? 4'b0001:
		           (E_funct3 == `STORE_HALF) ? 4'b0011:
		           (E_funct3 == `STORE_WORD) ? 4'b1111:
		           4'b0000;

	always @(posedge clk)begin
		if(~rst_n)begin
			AXI_AWVALID <= 1'b0;
			AXI_WVALID  <= 1'b0;
			AXI_WDATA   <= 32'h0000_0000;
		end else begin
			if(store_en)begin
				AXI_AWVALID <= 1'b1;
				AXI_WVALID  <= 1'b1;
				AXI_WDATA   <= write_data;
			end
			if(AXI_AWVALID && AXI_AWREADY)AXI_AWVALID <= 0;
			if(AXI_WVALID && AXI_WREADY)AXI_WVALID <= 0;
			if(AXI_WVALID && AXI_WREADY)AXI_WVALID <= 0;
		end
	end

	always @(posedge clk) begin
		if(~rst_n) begin
			AXI_AWADDR <= 32'h0000_0000;
			AXI_WSTRB  <= 4'b0000;
		end else if(store_en)begin
			AXI_AWADDR <= mem_addr;
			AXI_WSTRB  <= wstrb;
		end
	end

	always @(posedge clk) begin
		if(~rst_n) begin
			AXI_BREADY <= 1'b0;
		end else begin
			if(AXI_BVALID) AXI_BREADY <= 1'b1;
			if(AXI_BVALID && AXI_BREADY) AXI_BREADY <= 1'b0;
		end
	end
	assign AXI_AWPROT = 3'b0;


// output
	wire output_en;
	assign output_en = e_en &&( E_opcode == `OP_STORE_IO);
	always @(posedge clk) begin
		if(~rst_n || (UART_OUTPUT_TREADY && UART_OUTPUT_TVALID)) begin
			 UART_OUTPUT_TVALID <= 1'b0;
		end else if(output_en) begin
			 UART_OUTPUT_TVALID <= 1'b1 ;
		end
	end
	always @(posedge clk) begin
		if(output_en) begin
			 UART_OUTPUT_TDATA <= E_rs2[7:0];
		end
	end

// input
	wire input_en;
	assign input_en = e_en && E_opcode == `OP_LOAD_IO;

	always @(posedge clk) begin
		if(~rst_n || (UART_INPUT_TREADY && UART_INPUT_TVALID)) begin
			UART_INPUT_TREADY <= 1'b0;
		end else if(input_en)begin
			UART_INPUT_TREADY <= 1'b1;
		end
	end

endmodule

`default_nettype wire
