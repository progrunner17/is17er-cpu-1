`default_nettype none

`include "include.vh"

module cpu_top (
	input wire clk,
	input wire rst_n,
	input wire run,

	// fetch
	output reg [31:0] pc, //instruction address
	input wire [31:0] instr_code,

     // AXI4-lite master memory interface
     output wire                      axi_awvalid,
     input  wire                       axi_awready,
     output wire [31:0]               axi_awaddr,
     output wire [2:0]                 axi_awprot,

     output wire                      axi_wvalid,
     input  wire                       axi_wready,
     output wire [31:0]                axi_wdata,
     output wire [3:0]                 axi_wstrb,

     input  wire                       axi_bvalid,
     output wire                      axi_bready,
     input  wire [1:0]                 axi_bresp,

     output wire                      axi_arvalid,
     input wire                       axi_arready,
     output wire [31:0]                axi_araddr,
     output wire [2:0]                 axi_arprot,

     input wire                       axi_rvalid,
     output wire                       axi_rready,
     input wire [31:0]                axi_rdata,
     input wire [1:0]                 axi_rresp
);



// total
logic [2:0] cpu_state;
logic mem_lock;
reg [31:0] pc;


// decode
logic [6:0] opcode;
logic [2:0] op_ctrl;
logic op_switch;

wire [4:0] rs1_addr,rs2_addr;
logic [31:0] imm;
logic [4:0] waddr;
logic we_de;


decode decode (
	.clk       (clk       ),
	.rst_n     (rst_n     ),
	.instr_code(instr_code),
	.opcode    (opcode    ),
	.op_ctrl   (op_ctrl   ),
	.op_switch (op_switch ),
	.rs1_addr  (rs1_addr  ),
	.rs2_addr  (rs2_addr  ),
	.imm       (imm       ),
	.waddr     (waddr     ),
	.we        (we_de        )
);



// register

logic [31:0] rs1,rs2,wdata;
register register (
	.clk    (clk      ),
	.rst_n  (rst_n    ),
	.waddr  (waddr    ),
	.we     (we       ),
	.wdata  (wdata),
	.rs1_addr(rs1_addr  ),
	.rs1    (rs1      ),
	.rs2_addr(rs2_addr  ),
	.rs2    (rs2      )
);




//execute
logic jmp_addr;
logic b_en;
logic [31:0] rd;

execute execute (
	.clk        (clk        ),
	.rst_n      (rst_n      ),
	.pc         (pc         ),
	.opcode     (opcode     ),
	.op_ctrl    (op_ctrl    ),
	.op_switch  (op_switch  ),
	.rs1        (rs1        ),
	.rs2        (rs2        ),
	.imm        (imm        ),
	.b_en       (b_en       ),
	.jmp_addr   (jmp_addr   ),
	.mem_lock   (mem_lock   ),
	.rd         (rd         ),
	.axi_awvalid(axi_awvalid),
	.axi_awready(axi_awready),
	.axi_awaddr (axi_awaddr ),
	.axi_awprot (axi_awprot ),
	.axi_wvalid (axi_wvalid ),
	.axi_wready (axi_wready ),
	.axi_wdata  (axi_wdata  ),
	.axi_wstrb  (axi_wstrb  ),
	.axi_bvalid (axi_bvalid ),
	.axi_bresp  (axi_bresp  ),
	.axi_bready (axi_bready ),
	.axi_arready(axi_arready),
	.axi_arvalid(axi_arvalid),
	.axi_araddr (axi_araddr ),
	.axi_arprot (axi_arprot ),
	.axi_rready (axi_rready ),
	.axi_rvalid (axi_rvalid ),
	.axi_rresp  (axi_rresp  )
);

// write back;

wire we;
assign we = we_de || (opcode == `OP_LOAD && (axi_rready && axi_rvalid));

wire [31:0 ] read_data;
//switch byte, half word, word,
assign read_data =	(op_ctrl == 3'b000) ? {{24{axi_rdata[7]}},axi_rdata[7:0]}:
				 	op_ctrl == 3'b001 ? {{16{axi_rdata[15]}},axi_rdata[15:0]}:
				 	op_ctrl == 3'b100 ? {24'b0,axi_rdata[7:0]}:
				 	op_ctrl == 3'b101 ? {16'b0,axi_rdata[15:0]}:
				 	axi_rdata;


assign wdata = (opcode == `OP_LOAD) ? read_data: rd;



always @(posedge clk)begin
	if(rst_n | ~run )begin
		cpu_state <= `STATE_IDLE;
		mem_lock <= 1;
		pc <= 0;
	end else  begin
		case (cpu_state)
			`STATE_IDLE :
				begin
					if(run)begin
						pc <= `PC_BASE;
						cpu_state <= `STATE_WF;
					end
				end
			`STATE_FD :
				begin
					cpu_state <= `STATE_DE;

				end
			`STATE_DE :
				begin
					cpu_state <= `STATE_EW;
					mem_lock <= 0;
				end
			`STATE_EW :begin
				if(opcode == `OP_LOAD)begin
					if(axi_rvalid && axi_rready) begin 
						cpu_state <= `STATE_WF;
						pc <= pc + 4;
					end
				end else if(opcode == `OP_STORE)begin
					if(axi_wvalid && axi_wready) begin
						cpu_state <= `STATE_WF;
						pc <= pc + 4;
					end	
				end if((opcode ==`OP_BRANCH && b_en)||opcode == `OP_JAL || opcode == `OP_JALR)  begin
					 cpu_state <= `STATE_WF;
					 pc <= jmp_addr;
				end else begin
					 pc <= pc + 4;					
				end

				mem_lock <= 1;
			end
			`STATE_WF : cpu_state <=  `STATE_FD;
			default : begin 
				cpu_state <= `STATE_IDLE;
			end
		endcase
	end
end


endmodule


`default_nettype wire