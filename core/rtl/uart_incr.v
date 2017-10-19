module usrt_incr (
	input clk,    // Clock
	input clk_en, // Clock Enable
	input rst_n,  // Asynchronous reset active low

	// AXI4-lite master memory interface
    output wire                      axi_awvalid,
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
    input wire [31:0]                axi_rdata,
    input wire [1:0]                 axi_rresp
);

reg [1:0] state = 0;

wire get_state ;

parameter get_rx_state =2'h0 ;
parameter read = 2'h1;
parameter get_tx_state = 2'h2;
parameter wrie = 2'h3 ;

assign

reg [31:0] tmp = 0;

reg start = 0;

//read
always @(posedge clk) begin
	if(~rst_n) begin
	 <= 0;
	end else begin

		if(start) begin
			start <= 0;
			if(state == 2'b11)begin
				axi_awvalid <= 1'b1;
				axi_wvalid <= 1'b1;
				axi_wdata <= tmp;
			end else begin
				axi_arvalid <= 1'b1;
				axi_rready <= 1'b1;
				axi_araddr <= (~state[0]) ? : ;
			end
		end

		if(axi_arready && axi_arvalid) begin //negate arvalid
			axi_arvalid <= 0;
		end

		if(axi_rready && axi_rvalid) begin //negate rready
			axi_rready <= 0;
		end

		if(axi_awready && axi_awvalid) begin //negate awvalid
			axi_awvalid <= 0;
		end

		if(axi_wready && axi_wvalid) begin //negate wvalid
			axi_wvalid <= 0;
		end

		if(axi_wready || axi_rvalid)begin //change state
			case (state)
				get_rx_state:begin
				end
				read:begin
				end
				get_tx_state:begin
				end
				write:begin
				end
			endcase
		end
	end
end



always @(posedge clk) begin
	if(rst) begin
		 <= 0;
	end else begin
		 <= ;
	end
end

endmodule