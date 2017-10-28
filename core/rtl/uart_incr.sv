`default_nettype none


module usrt_incr_v #(parameter base_addr = 32'h0000_0000) (
	input wire  clk,    // Clock
	input wire rst_n,  // Asynchronous reset active lo

	// AXI4-lite master memory interface
    output reg                      axi_awvalid,
    input  wire                       axi_awready,
    output reg [31:0]              	 axi_awaddr,
    output wire [2:0]                 axi_awprot,

    output reg                      axi_wvalid,
    input  wire                       axi_wready,
    output reg [31:0]                axi_wdata,
    output wire [3:0]                 axi_wstrb,

    input  wire                       axi_bvalid,
    output reg                      axi_bready,
    input  wire [1:0]                 axi_bresp,

    output reg                      axi_arvalid,
    input wire                       axi_arready,
    output reg [31:0]                axi_araddr,
    output wire [2:0]                 axi_arprot,

    input wire                       axi_rvalid,
    output reg                       axi_rready,
(* mark_debug = "true" *)    input wire [31:0]       axi_rdata,
    input wire [1:0]                 axi_rresp
);

(* mark_debug = "true" *) logic [1:0] state = 2'b00;

logic start = 1'b1;
(* mark_debug = "true" *) logic next;




parameter get_rx_state =2'h0 ;
parameter read = 2'h1;
parameter get_tx_state = 2'h2;
parameter write = 2'h3 ;

assign axi_wstrb = 4'b0001;





assign next = (axi_wready || axi_rvalid)&&(((state == get_rx_state) && axi_rdata[0]) || (state == read) || ((state ==get_tx_state) && ~axi_rdata[3]) || (state == write));

//read
always @(posedge clk) begin
	if(~rst_n) begin
	 axi_awvalid<= 32'b0;
	 axi_arvalid<= 32'b0;
	 axi_wvalid<= 32'b0;
	 axi_rready<= 32'b0;
	 axi_wdata <= 32'b0;
	 start <= 1'b1;
	end else begin

		if(start) begin
			start <= 2'b00;
			if(state == 2'b11)begin
				axi_awvalid <= 1'b1;
				axi_wvalid <= 1'b1;
				axi_awaddr <= base_addr + 32'd4;
			end else begin
				axi_arvalid <= 1'b1;
				axi_rready <= 1'b1;
				axi_araddr <= (~state[0]) ? (base_addr + 32'd8) :base_addr;
			end
		end

		if(axi_arready && axi_arvalid) begin //negate arvalid
			axi_arvalid <= 0;
		end

		if(axi_rready && axi_rvalid) begin //negate rready
			axi_rready <= 0;
			start <= 1'b1;
		end

		if(axi_awready && axi_awvalid) begin //negate awvalid
			axi_awvalid <= 0;
		end

		if(axi_wready && axi_wvalid) begin //negate wvalid
			axi_wvalid <= 0;
			start <= 1'b1;
		end

		if(next)begin //change state
			state <= state + 1;

			if(state == read) axi_wdata <= axi_rdata;
		end
	end
end



always @(posedge clk) begin
	if(~rst_n) begin
		 axi_bready <= 1'b1;
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