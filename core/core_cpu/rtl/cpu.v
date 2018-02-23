`default_nettype none

`include "./include.vh"

module cpu #(
	parameter INSTR_ADDR_WIDTH = 14
)(
clk,rst_n,start,instr_code,instr_addr,instr_en,
ef_en,f_rs1,f_frs1,f_frs2,f_funct3,f_funct5,fp_valid,fp_data,
AXI_AWREADY,AXI_AWVALID,AXI_AWADDR,AXI_AWPROT,
AXI_WREADY, AXI_WVALID, AXI_WDATA, AXI_WSTRB,
AXI_BREADY, AXI_BVALID, AXI_BRESP,
AXI_ARREADY,AXI_ARVALID,AXI_ARADDR,AXI_ARPROT,
AXI_RREADY, AXI_RVALID, AXI_RDATA, AXI_RRESP,
UART_INPUT_TDATA, UART_INPUT_TREADY ,UART_INPUT_TVALID,
UART_OUTPUT_TDATA,UART_OUTPUT_TREADY,UART_OUTPUT_TVALID);
input  wire 					clk;
input  wire 					rst_n;
input  wire 					start;
input  wire [31:0] 				instr_code;
output reg  [INSTR_ADDR_WIDTH - 1:0] 	instr_addr = 0;
output wire 					instr_en;


output wire 		ef_en;
output wire [31:0] 	f_rs1;
output wire [31:0] 	f_frs1;
output wire [31:0] 	f_frs2;
output wire [2:0]  	f_funct3;
output wire [4:0]  	f_funct5;
input  wire 		fp_valid;
input  wire [31:0] 	fp_data;



output wire                  AXI_AWVALID ;
input  wire                  AXI_AWREADY ;
output wire [          31:0] AXI_AWADDR  ;
output wire [           2:0] AXI_AWPROT  ;
output wire                  AXI_WVALID  ;
input  wire                  AXI_WREADY  ;
output wire [          31:0] AXI_WDATA   ;
output wire [           3:0] AXI_WSTRB   ;
input  wire                  AXI_BVALID  ;
output wire                  AXI_BREADY  ;
input  wire [           1:0] AXI_BRESP   ;
output wire                  AXI_ARVALID ;
input  wire                  AXI_ARREADY ;
output wire [          31:0] AXI_ARADDR  ;
output wire [           2:0] AXI_ARPROT  ;
input  wire                  AXI_RVALID  ;
output wire                  AXI_RREADY  ;
input  wire [          31:0] AXI_RDATA   ;
input  wire [           1:0] AXI_RRESP   ;



input  wire [           7:0] UART_INPUT_TDATA  ;
output wire                  UART_INPUT_TREADY ;
input  wire                  UART_INPUT_TVALID ;
output wire [           7:0] UART_OUTPUT_TDATA ;
output wire                  UART_OUTPUT_TVALID;
input  wire                  UART_OUTPUT_TREADY;



//assign pc = instr_addr[7:0];

	reg F_val  = 1'b0;
	reg D_val  = 1'b0;
	reg E_val  = 1'b0;
	reg W_val  = 1'b0;
	wire f_en;
	wire d_en;
	wire e_en;
	wire w_en;
	wire w_fin;
	wire pc_en;
	reg FINISH = 1'b0;

	wire valid;
	assign valid = ((AXI_RREADY && AXI_RVALID) || (AXI_WREADY && AXI_WVALID) || (UART_INPUT_TREADY && UART_INPUT_TVALID) || (UART_OUTPUT_TREADY && UART_OUTPUT_TVALID) || fp_valid);
	wire wait_valid;



	reg  [INSTR_ADDR_WIDTH-1:0] D_pc = 0;
	wire [INSTR_ADDR_WIDTH-1:0] E_pc;
	wire [INSTR_ADDR_WIDTH-1:0] W_pc_incr;
	wire [INSTR_ADDR_WIDTH-1:0] W_jmp_addr;
	wire [INSTR_ADDR_WIDTH-1:0] next_pc;
	wire  W_jmp_en;



// opcode and operands
	wire [4:0] E_opcode;
	wire [4:0] E_funct5;
	wire [2:0] E_funct3;

	wire [31:0] E_rs1;
	wire [31:0] E_rs2;
	wire [31:0] E_frs1;
	wire [31:0] E_frs2;
	wire [31:0] E_imm;
	wire [4:0] rs1_addr;
	wire [4:0] rs2_addr;


assign f_rs1 = E_rs1;
assign f_frs1 = E_frs1;
assign f_frs2 = E_frs2;
assign f_funct3 = E_funct3;
assign f_funct5 = E_funct5;




// write back control
	wire [4:0] E_rd_addr;
	wire [4:0] W_rd_addr;
	wire [`WF_WIDTH-1:0] E_write_flags;
	wire [`WF_WIDTH-1:0] W_write_flags;
	wire [31:0] wdata;
	wire [31:0] W_rd;
	assign wait_valid = W_write_flags[3];

	//en 今やっているものが終了できる

	assign instr_en = f_en;
	assign pc_en = ( start || ~FINISH &&  w_fin);
	assign f_en =   F_val && (~D_val || d_en );
	assign d_en =   D_val && (instr_code[1:0] != 2'b00) &&  (~E_val || e_en);
	assign e_en =   E_val && (~W_val || w_fin);
	assign ef_en =  e_en && E_write_flags[1];
	assign w_en  =   W_val ;
	assign w_fin =   W_val && ( ~wait_valid || valid) ;

// state machine
	always @(posedge clk) begin
		if(~rst_n || start) FINISH <= 1'b0;
		else if(instr_code[1:0] != 2'b11 && D_val)FINISH <= 1'b1 ;
	end

	always @(posedge clk) begin
		if(~rst_n ) F_val <= 1'b0;
		else if(f_en || ~F_val || start)F_val <= pc_en;
	end

	always @(posedge clk) begin
		if(~rst_n || start)D_val <= 0;
		else if(d_en  || ~D_val)D_val <= f_en;
	end

	always @(posedge clk) begin
		if(~rst_n || start) E_val <= 0;
		else if(e_en  || ~E_val) E_val <= d_en;
	end

	always @(posedge clk) begin
		if(~rst_n || start) W_val <= 0;
		else if(w_fin  || ~W_val) W_val <= e_en;
	end





// pc
assign next_pc = start ? `INST_BASE_ADDR:
		W_jmp_en ? W_jmp_addr:
		W_pc_incr;
always @(posedge clk) begin
	if(~rst_n) begin
		instr_addr <= 0;
	end else if(pc_en) begin
		instr_addr <= next_pc;
	end
end


always @(posedge clk) begin
	if(~rst_n) begin
 		D_pc <= 0;
	end else if(f_en)begin
 		D_pc <= instr_addr ;
	end
end


	wire axi_flag;//0
	assign axi_flag = W_write_flags[0];
	wire fip_flag;//1
	assign fip_flag = W_write_flags[1];
	wire rd_flag;//2
	assign rd_flag = W_write_flags[2];
	// wire wait_valid;//3
	wire fwe;//4
	assign fwe = w_fin && W_write_flags[4];
	wire xwe;//5
	assign xwe = w_fin && W_write_flags[5];
	wire input_flag;//6
	assign input_flag = W_write_flags[6];

assign wdata = 	fip_flag ? fp_data :
				axi_flag ? AXI_RDATA :
				input_flag ?  UART_INPUT_TDATA :
				W_rd ;


decode  #(.INSTR_ADDR_WIDTH(INSTR_ADDR_WIDTH)) i_decode  (
	.clk          (clk          ),
	.rst_n        (rst_n        ),
	.d_en         (d_en         ),
	.instr_code   (instr_code   ),
	.D_pc         (D_pc         ),
	.E_pc         (E_pc         ),
	.E_opcode     (E_opcode     ),
	.E_funct5     (E_funct5     ),
	.E_funct3     (E_funct3     ),
	.E_imm        (E_imm        ),
	.rs1_addr     (rs1_addr     ),
	.rs2_addr     (rs2_addr     ),
	.E_rd_addr    (E_rd_addr    ),
	.E_write_flags(E_write_flags)
);


register i_register (
	.clk     (clk      ),
	.rst_n   (rst_n    ),
	.d_en    (d_en     ),
	.xwe     (xwe      ),
	.rd_addr (E_rd_addr),
	.wdata   (wdata    ),
	.rs1_addr(rs1_addr ),
	.E_rs1   (E_rs1    ),
	.rs2_addr(rs2_addr ),
	.E_rs2   (E_rs2    )
);

fregister i_fregister (
	.clk     (clk      ),
	.rst_n   (rst_n    ),
	.d_en    (d_en     ),
	.fwe     (fwe      ),
	.rd_addr (E_rd_addr),
	.wdata   (wdata    ),
	.rs1_addr(rs1_addr ),
	.E_frs1  (E_frs1   ),
	.rs2_addr(rs2_addr ),
	.E_frs2  (E_frs2   )
);


execute #(.INSTR_ADDR_WIDTH(INSTR_ADDR_WIDTH)) i_execute  (
	.clk               (clk               ),
	.rst_n             (rst_n             ),
	.e_en              (e_en              ),
	.E_pc              (E_pc              ),
	.W_pc_incr         (W_pc_incr         ),
	.E_opcode          (E_opcode          ),
	.E_funct5          (E_funct5          ),
	.E_funct3          (E_funct3          ),
	.E_rs1             (E_rs1             ),
	.E_imm             (E_imm),
	.E_rs2             (E_rs2             ),
	.E_frs1            (E_frs1            ),
	.E_frs2            (E_frs2            ),
	.W_jmp_en          (W_jmp_en          ),
	.W_jmp_addr        (W_jmp_addr        ),
	.E_rd_addr         (E_rd_addr         ),
	.E_write_flags     (E_write_flags     ),
	.W_rd_addr         (W_rd_addr         ),
	.W_write_flags     (W_write_flags     ),
	.W_rd              (W_rd              ),
	.AXI_AWVALID       (AXI_AWVALID       ),
	.AXI_AWREADY       (AXI_AWREADY       ),
	.AXI_AWADDR        (AXI_AWADDR        ),
	.AXI_AWPROT        (AXI_AWPROT        ),
	.AXI_WVALID        (AXI_WVALID        ),
	.AXI_WREADY        (AXI_WREADY        ),
	.AXI_WDATA         (AXI_WDATA         ),
	.AXI_WSTRB         (AXI_WSTRB         ),
	.AXI_BVALID        (AXI_BVALID        ),
	.AXI_BREADY        (AXI_BREADY        ),
	.AXI_ARVALID       (AXI_ARVALID       ),
	.AXI_ARREADY       (AXI_ARREADY       ),
	.AXI_ARADDR        (AXI_ARADDR        ),
	.AXI_ARPROT        (AXI_ARPROT        ),
	.AXI_RVALID        (AXI_RVALID        ),
	.AXI_RREADY        (AXI_RREADY        ),
	.UART_INPUT_TREADY (UART_INPUT_TREADY ),
	.UART_INPUT_TVALID (UART_INPUT_TVALID ),
	.UART_OUTPUT_TDATA (UART_OUTPUT_TDATA ),
	.UART_OUTPUT_TVALID(UART_OUTPUT_TVALID),
	.UART_OUTPUT_TREADY(UART_OUTPUT_TREADY)
);

endmodule

`default_nettype  wire