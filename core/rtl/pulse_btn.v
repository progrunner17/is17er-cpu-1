`default_nettype none

module pulse_btn( input wire btn,
                  input wire rst_btn,
                  output reg pulse,
		  output wire statn,
                  input wire clk,
                  input wire rstn );
   reg                 stat_m;
   reg                 stat_s;

   assign statn = ~ (stat_m || stat_s);

   always @(posedge clk) begin
      pulse <= 1'b0;
      if (~rstn) begin
         stat_m <= 1'b0;
         stat_s <= 1'b0;
      end else begin
         if (btn) begin
            stat_m <= 1'b1;
         end
         if (stat_m && ~stat_s) begin
            pulse <= 1'b1;
            stat_s <= 1'b1;
         end
         if (rst_btn) begin
            stat_m <= 1'b0;
            stat_s <= 1'b0;
            pulse <= 1'b0;
         end
      end
   end
endmodule

`default_nettype wire
