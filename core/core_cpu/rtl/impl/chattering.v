`default_nettype none

module chattering(clk,rst_n,din,dout);
input wire clk;
input wire rst_n;
input wire din;
output reg  dout = 1'b0;
reg [25:0] count = 0;

  always @(posedge clk) begin
    if(~rst_n || ~din) begin
        count <= 6'b0;
    end else if(din) begin
        count <= count + 1;
    end
  end

  always @(posedge clk) begin
    if(count == 26'h0200000) begin
       dout <= 1'b1;
    end else begin
       dout <= 1'b0;
    end
  end
endmodule


`default_nettype wire