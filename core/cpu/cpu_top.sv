`default_nettype none

`include "include.vh"

module cpu_top (
	input wire clk,
	input wire rst_n,

	// fetch
	output reg [31:0] pc, //instruction address
	input wire [31:0] instr_code,

     // AXI4-lite master memory interface
	     // address write channel
	     output wire                      axi_awvalid,
	     input wire                       axi_awready,
	     output wire [31:0]               axi_awaddr,
	     output wire [2:0]                 axi_awprot,
	     // data write channel
	     output wire                      axi_wvalid,
	     input wire                       axi_wready,
	     output wire [31:0]                axi_wdata,
	     output wire [3:0]                 axi_wstrb,
	     // response channel
	     input wire                       axi_bvalid,
	     output wire                      axi_bready,
	     input wire [1:0]                 axi_bresp,
	     // address read channel
	     output wire                      axi_arvalid,
	     input wire                       axi_arready,
	     output wire [31:0]                axi_araddr,
	     output wire [2:0]                 axi_arprot,
	     // read data channel
	     input wire                       axi_rvalid,
	     output wire                       axi_rready,
	     input wire [31:0]                axi_rdata,
	     input wire [1:0]                 axi_rresp
);

// total
logic run;
logic [2:0] cpu_state;

// fetch
// reg   reset_memory = 1;
// output_reg  [31:0] pc;
// input wire  [31:0] instr_code;

// decode
reg [6:0] opcode;
wire [2:0] op_ctrl;
wire op_switch;
wire op_imm;
wire [4:0] shamt;
wire [4:0] rs1_addr,rs2_addr,w_addr;
logic [31:0] rs1,rs2,imm;
wire m_write;
wire m_read;

decode decode (
	.clk      (clk      ),
	.rst_n    (rst_n    ),
	.instr_code(instr_code),
	.opcode   (opcode   ),
	.op_ctrl  (op_ctrl  ),
	.op_switch(op_switch),
	.rs1_addr (rs1_addr ),
	.rs2_addr (rs2_addr ),
	.w_addr   (w_addr   ),
	.we        (we),
	.imm      (imm      ),
	.shamt    (shamt    )
);

wire [4:0] waddr;
wire we;
wire [4:0] rs1addr;
wire [4:0] rs2addr;
wire pc_we;
wire pc_wdata;

register register (
	.clk     (clk      ),
	.rst_n   (rst_n    ),
	.waddr   (waddr    ),
	.we      (we       ),
	.wdata   (axi_wdata),
	.rs1addr (rs1addr  ),
	.rs1     (rs1      ),
	.rs2addr (rs2addr  ),
	.rs2     (rs2      ),
	.pc_we   (pc_we    ),
	.pc_wdata(pc_wdata ),
	.pc      (pc       )
);

//execute
wire [31:0] op1,op2;
wire [31:0] w_data;
wire exe_fin;
wire jmp_addr;
wire b_en;



	wire [31:0] address;
	reg reset_memory;
execute execute (
	.clk         (clk         ),
	.rst_n       (rst_n       ),
	.pc          (pc          ),
	.rs1         (rs1         ),
	.rs2         (rs2         ),
	.imm         (imm         ),
	.opcode      (opcode      ),
	.op_ctrl     (op_ctrl     ),
	.op_switch   (op_switch   ),
	.op_imm      (op_imm      ),
	.shamt       (shamt       ),
	.address     (address     ),
	.m_write     (m_write     ),
	.m_read      (m_read      ),
	.reset_memory(reset_memory),
	.wdata       (axi_wdata   ),
	.exe_fin     (exe_fin     ),
	.b_en        (b_en        ),
	.jmp_addr    (jmp_addr    ),
	.axi_awready (axi_awready ),
	.axi_awaddr  (axi_awaddr  ),
	.axi_awprot  (axi_awprot  ),
	.axi_wready  (axi_wready  ),
	.axi_wdata   (axi_wdata   ),
	.axi_wstrb   (axi_wstrb   ),
	.axi_bvalid  (axi_bvalid  ),
	.axi_bresp   (axi_bresp   ),
	.axi_arready (axi_arready ),
	.axi_araddr  (axi_araddr  ),
	.axi_arprot  (axi_arprot  ),
	.axi_rvalid  (axi_rvalid  ),
	.axi_rdata   (axi_rdata   ),
	.axi_rresp   (axi_rresp   )
);

// write back;

always @(posedge clk)begin
	if(rst_n | ~run )begin
		cpu_state <= `STATE_IDLE;
		run <= 0;
	end else  begin
		case (cpu_state)
			`STATE_IDLE :
				begin
					if(run)begin
						pc <= `PC_BASE;
						cpu_state <= `STATE_WF;
						reset_memory <= 1;
					end
				end
			`STATE_FD :
				begin
					cpu_state <= `STATE_DE;
				end
			`STATE_DE :
				begin
					cpu_state <= `STATE_EW;

				end
			`STATE_EW :
				begin
					if(exe_fin)begin
						cpu_state <= `STATE_WF;
						if(b_en) pc <= jmp_addr;
						else pc <= pc + 4;
					end
				end
			`STATE_WF :
				begin
					cpu_state <= `STATE_FD;
					reset_memory <= 0;

				end
			default : begin cpu_state <= `STATE_IDLE;end
		endcase
	end
end


endmodule


`default_nettype wire