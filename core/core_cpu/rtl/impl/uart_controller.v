
`define OKAY 	2'b00
`define SLVERR 	2'b10
// 投機的実行
module uart_controller #(parameter BASE_ADDR        = 32'h4060_0000) (
	input  wire        clk              , // Clock
	input  wire        rst_n            , // Asynchronous reset active low
	// AXI4-lite master uart interface
	output reg         AXI_AWVALID        = 1'b0,
	input  wire        AXI_AWREADY      ,
	output wire [31:0] AXI_AWADDR       ,
	output wire [ 2:0] AXI_AWPROT       ,
	output reg         AXI_WVALID         = 1'b0,
	input  wire        AXI_WREADY       ,
	output reg  [31:0] AXI_WDATA          = 0 ,
	output wire [ 3:0] AXI_WSTRB        ,
	input  wire        AXI_BVALID       ,
	// 		output reg         AXI_BREADY  = 1'b0,
	output wire        AXI_BREADY       ,
	input  wire [ 1:0] AXI_BRESP        ,
	output reg         AXI_ARVALID        = 1'b0,
	input  wire        AXI_ARREADY      ,
	output wire [31:0] AXI_ARADDR       ,
	output wire [ 2:0] AXI_ARPROT       ,
	input  wire        AXI_RVALID       ,
	output reg         AXI_RREADY         = 1'b0,
	input  wire [31:0] AXI_RDATA        ,
	input  wire [ 1:0] AXI_RRESP        ,
	// AXI4-stream slave memory interface
	input  wire [ 7:0] UART_WRITE_TDATA ,
	output reg         UART_WRITE_TREADY  = 1'b0,
	input  wire        UART_WRITE_TVALID,
	output reg  [ 7:0] UART_READ_TDATA    = 8'h00,
	output reg         UART_READ_TVALID   = 1'b0,
	input  wire        UART_READ_TREADY
);
	assign AXI_AWADDR = BASE_ADDR + 4;
	assign AXI_ARADDR = BASE_ADDR;
	assign AXI_WSTRB  = 4'b0001;
	assign AXI_AWPROT = 0;
	assign AXI_ARPROT = 0;
	assign AXI_BREADY = 1;

// send module
	reg  write_buf_is_set = 0;
	wire accept_data         ;
	assign accept_data = ~write_buf_is_set  && UART_WRITE_TVALID;

	wire send_succ;
	assign send_succ = AXI_BVALID && (AXI_BRESP == `OKAY);
	wire send_err;
	assign send_err = AXI_BVALID && (AXI_BRESP == `SLVERR);


	always @(posedge clk) begin
		if(~rst_n || send_succ) begin
			write_buf_is_set <= 0;
		end else if(accept_data )begin
			write_buf_is_set <= 1;
		end
	end

	always @(posedge clk) begin
		if(~rst_n || (AXI_AWREADY && AXI_AWVALID)) begin
			AXI_AWVALID <= 0;
		end else if(accept_data || send_err)begin
			AXI_AWVALID <= 1;
		end
	end

	always @(posedge clk) begin
		if(~rst_n || (AXI_WREADY && AXI_WVALID)) begin
			AXI_WVALID <= 0;
		end else if(accept_data || send_err) begin
			AXI_WVALID <= 1;
		end
	end

	// TVALIDが先、TREADYでTVALIDを下げる
	always @(posedge clk) begin
		if(~rst_n || (UART_WRITE_TREADY && UART_WRITE_TVALID)) begin
			UART_WRITE_TREADY <= 0;
		end else if(accept_data) begin
			UART_WRITE_TREADY <= 1;
		end
	end

	// always @(posedge clk) begin
	// 	if(~rst_n || (AXI_BREADY && AXI_BVALID)) begin
	// 	 AXI_BREADY <= 0;
	// 	end else if(accept_data || send_err) begin
	// 	 AXI_BREADY <= 1;
	// 	end
	// end


	always @(posedge clk) begin
		if(~rst_n) begin
			AXI_WDATA <= 0;
		end else if(accept_data	)begin
			AXI_WDATA[7:0] <= UART_WRITE_TDATA;
		end
	end

// receive module
	wire receiving;
	assign receiving = AXI_RREADY || AXI_ARVALID;

	always @(posedge clk) begin : proc_
		if(~rst_n || (AXI_ARREADY && AXI_ARVALID)) begin
			AXI_ARVALID <= 0;
		end else if(~receiving && ~UART_READ_TVALID )begin
			AXI_ARVALID <= 1;
		end
	end

	always @(posedge clk) begin
		if(~rst_n || (AXI_RREADY && AXI_RVALID)) begin
			AXI_RREADY <= 0;
		end else if(~receiving && ~UART_READ_TVALID)begin
			AXI_RREADY <= 1;
		end
	end

	always @(posedge clk) begin
		if(~rst_n ||(UART_READ_TREADY && UART_READ_TVALID)) begin
			UART_READ_TVALID <= 0;
		end else if(AXI_RVALID && AXI_RRESP == `OKAY) begin
			UART_READ_TVALID <= 1;
		end
	end


	always @(posedge clk ) begin
		if(~rst_n) begin
			UART_READ_TDATA <= 0;
		end else if(AXI_RVALID && AXI_RRESP == `OKAY) begin
			UART_READ_TDATA <= AXI_RDATA[7:0];
		end
	end
endmodule
