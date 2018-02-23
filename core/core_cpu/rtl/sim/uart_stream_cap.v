


`default_nettype  none

module uart_stream_cap (
clk,rst_n,
STREAM_WRITE_TDATA,
STREAM_WRITE_TREADY,
STREAM_WRITE_TVALID,
STREAM_READ_TDATA,
STREAM_READ_TVALID,
STREAM_READ_TREADY
);
	input  wire clk;
	input  wire rst_n;
	input  wire [7:0] STREAM_WRITE_TDATA ;
	output reg        STREAM_WRITE_TREADY = 1'b0;
	input  wire       STREAM_WRITE_TVALID;
	output reg  [7:0] STREAM_READ_TDATA   = 8'h00;
	output reg        STREAM_READ_TVALID  = 1'b0;
	input  wire       STREAM_READ_TREADY;



// assign STREAM_WRITE_TDATA = 8'h12;


always @(posedge clk) begin
	STREAM_READ_TDATA <= STREAM_WRITE_TDATA;
end

always @(posedge clk) begin
	if(~rst_n || STREAM_WRITE_TREADY && STREAM_WRITE_TVALID) begin
		STREAM_WRITE_TREADY <= 0;
	end else if(STREAM_WRITE_TVALID) begin
		STREAM_WRITE_TREADY <= 1'b1;
	end
end



always @(posedge clk) begin
	if(~rst_n || STREAM_READ_TREADY && STREAM_READ_TVALID ) begin
		$write("%x %d\n",STREAM_READ_TDATA,STREAM_READ_TDATA);
		 STREAM_READ_TVALID <= 1'b0;
	end else if(STREAM_READ_TREADY) begin
		 STREAM_READ_TVALID <= 1'b1;
	end
end






endmodule
`default_nettype wire
