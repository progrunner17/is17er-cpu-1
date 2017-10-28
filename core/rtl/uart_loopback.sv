`default_nettype none


module uart_loopback_sv #(parameter base_addr = 32'h0000_0000) (
	input wire  clk,    // Clock
(* mark_debug = "true" *)	input wire start,
	input wire rst_n,  // Asynchronous reset active lo

	// AXI4-lite master memory interface
    output reg                      axi_awvalid,
    input  wire                       axi_awready,
    output wire [31:0]              	 axi_awaddr,
    output wire [2:0]                 axi_awprot,

    output reg                      axi_wvalid = 0,
    input  wire                       axi_wready,
(* mark_debug = "true" *)    output reg [31:0]                axi_wdata = 0,
    output wire [3:0]                 axi_wstrb,

    input  wire                       axi_bvalid,
    output reg                      axi_bready = 0,
    input  wire [1:0]                 axi_bresp,

    output reg                      axi_arvalid = 0,
    input wire                       axi_arready,
    output reg [31:0]                axi_araddr = 0,
    output wire [2:0]                 axi_arprot,

    input wire                       axi_rvalid,
    output reg                       axi_rready = 0,
(* mark_debug = "true" *)    input wire [31:0]       axi_rdata,
    input wire [1:0]                 axi_rresp
);

(* mark_debug = "true" *) wire [3:0] state;


reg [7:0] tmp = 0;

reg rx_st;
reg read;
reg tx_st;
reg write;
asssign state = {write,tx_st,read,rx_st};


wire next_rx_st;
wire next_read;
wire next_tx_st;
wire next_write;

wire [31:0] araddr;
assign axi_awaddr = base_addr + 'h0000_0004;
assign araddr = next_read ? base_addr:
				(next_rx_st || next_tx_st) ? base_addr +'h0000_0008: 0;


assign next_rx_st = rst_n && (start || (write  &&  axi_wready && axi_wvalid)|| ( rx_st && ~axi_rdata[0]  && axi_rready && axi_rvalid));
assign next_read = rst_n &&  rx_st && axi_rvalid && axi_rdata[0] ;
assign next_tx_st = rst_n  && axi_rready && axi_rvalid &&  ( read || (tx_st && axi_rdata[3] )) ;
assign next_write = rst_n &&   tx_st && axi_rready && axi_rvalid && ~axi_rdata[3];


always @(posedge clk) begin
		 if(~rst_n)begin
		 	rx_st <= 1'b0;
		 end else begin
		 if(next_rx_st) begin
		 	rx_st <= 1'b1;
		 end 

		 if(next_read)begin
		 	rx_st <= 0;
		 end

		end
end

always @(posedge clk) begin
		 if(~rst_n)begin
		 	read <= 1'b0;
		 end else begin 
		 if(next_read) begin
		 	read <= 1'b1;
		 end 
		 if(next_tx_st)begin
		 	read <= 0;
		 end

		end
end

always @(posedge clk) begin
		 if(~rst_n) begin
		 	tx_st <= 1'b0;
		 end else begin 
		 if(next_tx_st) begin
		 	tx_st <= 1'b1;
		 end
		 if(next_write) begin
		 	tx_st <= 0;
		 end

		end
end

always @(posedge clk) begin
		 if(~rst_n)begin
		 	write <= 1'b0;
		 end else begin 
		 if(next_write) begin
		 	write <= 1'b1;
		 end

		 if(next_rx_st)begin
		 	write <= 0;
		 end
		end
end




assign axi_wstrb = 4'b0001;

always @(posedge clk) begin
	if(~rst_n) begin
		axi_arvalid <= 0;
		axi_araddr <= 0;
		axi_rready <= 0;
		axi_awvalid <= 0;
		axi_wvalid <= 0;
		axi_wdata <= 0;
	end else begin
		if(next_rx_st || next_read || next_tx_st)begin
			axi_arvalid <= 1;
			axi_araddr <= araddr;
			axi_rready <= 1;
		end

		if(axi_arready && axi_rvalid) axi_arvalid <= 0;

		if(axi_rready && axi_rvalid)begin 
			 axi_rready <= 0;
			 tmp <= axi_rdata[7:0];
		end

		if(next_write)begin
			axi_awvalid <= 1;
			axi_wvalid <= 1;
			axi_wdata<= {24'b0,tmp};
		end

		if(axi_awready && axi_awvalid) axi_awvalid <= 0;
		if(axi_wready && axi_wvalid) axi_wvalid <= 0;
		
	end
end




always @(posedge clk) begin
	if(~rst_n) begin
		 axi_bready <= 1'b0;
	end else begin
		  if(axi_awvalid) begin
		  	axi_bready <= 1'b1;
		  end
		  if(axi_bvalid & axi_bready)begin
		  	axi_bready <= 0;
		  end
	end
end

endmodule


`default_nettype wire

