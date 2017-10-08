`default_nettype none


module counter #(parameter N = 8) (
    input wire clk,up,down,resetn,
    output reg [N-1:0] outdata);



	always @(posedge clk) begin
		if (~resetn) outdata <= 0;
		if (up) outdata <= outdata + 1; 
		if (down) outdata <= outdata - 1;
	end

endmodule

`default_nettype wire