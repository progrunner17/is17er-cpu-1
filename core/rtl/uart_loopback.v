`default_nettype none


module uart_loopback #(parameter base_addr = 32'h0000_0000) (
	input wire  clk,    // Clock
	input wire start,
	input wire rst_n,  // Asynchronous reset active lo

	// AXI4-lite master memory interface
    output wire                      axi_awvalid,
    input  wire                       axi_awready,
    output wire [31:0]              	 axi_awaddr,
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
	input wire [31:0]       		axi_rdata,
    input wire [1:0]                 axi_rresp
);

uart_loopback_sv #(.base_addr(base_addr)) uart_loopback_sv  (
	.clk        (clk        ),
	.start      (start),
	.rst_n      (rst_n      ),
	.axi_awvalid(axi_awvalid),
	.axi_awready(axi_awready),
	.axi_awaddr (axi_awaddr ),
	.axi_awprot (axi_awprot ),
	.axi_wvalid (axi_wvalid ),
	.axi_wready (axi_wready ),
	.axi_wdata  (axi_wdata  ),
	.axi_wstrb  (axi_wstrb  ),
	.axi_bvalid (axi_bvalid ),
	.axi_bready (axi_bready ),
	.axi_bresp  (axi_bresp  ),
	.axi_arvalid(axi_arvalid),
	.axi_arready(axi_arready),
	.axi_araddr (axi_araddr ),
	.axi_arprot (axi_arprot ),
	.axi_rvalid (axi_rvalid ),
	.axi_rready (axi_rready ),
	.axi_rdata  (axi_rdata  ),
	.axi_rresp  (axi_rresp  )
);


endmodule


`default_nettype wire