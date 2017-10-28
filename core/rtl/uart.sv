

`default_nettype none


module uart_sv #(parameter base_addr = 32'h4000_0000) (
	input wire  clk,    // Clock
(*mark_debug = "true"*)input wire triger,
(*mark_debug = "true"*)input wire read_state,
(*mark_debug = "true"*)input wire read_data,
(*mark_debug = "true"*)input wire write_data,
	input wire rst_n,  // Asynchronous reset active lo

	// AXI4-lite master memory interface
    output reg                      axi_awvalid,
    input  wire                       axi_awready,
    output wire [31:0]              	 axi_awaddr,
    output wire [2:0]                 axi_awprot,

    output reg                      axi_wvalid,
    input  wire                       axi_wready,
	output reg [31:0]                axi_wdata,
    output wire [3:0]                 axi_wstrb,

    input  wire                       axi_bvalid,
    output reg                      axi_bready,
    input  wire [1:0]                 axi_bresp,

    output reg                      axi_arvalid = 0,
    input wire                       axi_arready,
    output reg [31:0]                axi_araddr = base_addr+8,
    output wire [2:0]                 axi_arprot,

    input wire                       axi_rvalid,
    output reg                       axi_rready = 0,
(*mark_debug = "true"*)	input wire [31:0]       		axi_rdata,
   	input wire [1:0]                 axi_rresp
);


assign  axi_awaddr = base_addr + 4;
assign axi_awprot = 3'b0;
assign axi_wstrb = 4'b0001;


reg [7:0] tmp = 0;


always @(posedge clk)begin
	if(~rst_n)begin
		axi_arvalid <= 0;
		axi_araddr <= 0;

		axi_rready <= 0;

		axi_awvalid <= 0;
		
		axi_wvalid <= 0;
		axi_wdata <= 0;
	end else begin 

		if(read_state || read_data)begin
			axi_arvalid <= 1;
			axi_rready <= 1;
		end

		if(read_state) axi_araddr <= base_addr + 8;
		if(read_data)  axi_araddr <= base_addr;

		if(axi_arready && axi_arvalid) axi_arvalid <= 0;
	
		if(axi_rready && axi_rvalid) begin 
			axi_rready <= 0;
			tmp <= axi_rdata[7:0];
		end 

		if(write_data)begin
			axi_awvalid <= 1;
			axi_wvalid <= 1;
			axi_wdata <= {24'b0,tmp};
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