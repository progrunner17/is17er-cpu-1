`default_nettype none

module state_machine (
	input wire clk,    // Clock
(* mark_debug = "true" *)input wire start,
	input wire rst_n  // Asynchronous reset active low
	
);

reg s1_v = 0;
reg s2_v = 0;
reg s3_v = 0;
reg s4_v = 0;
(* mark_debug = "true" *) wire [3:0] state;

assign state = {s1_v,s2_v,s3_v,s4_v};

wire next_s1_en;
wire next_s2_en;
wire next_s3_en;
wire next_s4_en;

assign next_s1_en = rst_n && ~s1_v  && (start || s4_v);
assign next_s2_en = rst_n && ~s2_v  && s1_v;
assign next_s3_en = rst_n && ~s3_v  && s2_v;
assign next_s4_en = rst_n && ~s4_v  && s3_v;


always @(posedge clk) begin
		 if(next_s1_en) begin
		 	s1_v <= 1'b1;
		 end else begin
		 	s1_v <= 1'b0;
		 end
end


always @(posedge clk) begin
		 if(next_s2_en) begin
		 	s2_v <= 1'b1;
		 end else begin
		 	s2_v <= 1'b0;
		 end
end


always @(posedge clk) begin
		 if(next_s3_en) begin
		 	s3_v <= 1'b1;
		 end else begin
		 	s3_v <= 1'b0;
		 end
end


always @(posedge clk) begin
		 if(next_s4_en) begin
		 	s4_v <= 1'b1;
		 end else begin
		 	s4_v <= 1'b0;
		 end
end


endmodule

`default_nettype wire