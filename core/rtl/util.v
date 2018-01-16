`default_nettype none


module counter(clk,rst_n,up,down,dout);

input wire clk;
input wire rst_n;
input wire up;
input wire down;
output reg [7:0] dout = 8'h00;

always @(posedge clk) begin
	if (~rst_n) dout <= 0;
	if (up) dout <= dout + 1;
	if (down) dout <= dout - 1;
end
endmodule


module btn_counter(clk,rst_n,up,down,dout);
input wire clk;
input wire rst_n;
input wire up;
input wire down;
output wire [7:0] dout;

wire pulse;
wire din = up || down;
wire din;


chattering i_chattering (.clk(clk), .rst_n(rst_n), .din(din), .dout(pulse));
counter i_counter (.clk(clk), .rst_n(rst_n), .up(up && pulse), .down(down && pulse), .dout(dout));


endmodule


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


module switch(clk,rst_n,din,dout);
input   wire clk;
input   wire rst_n;
input   wire din;
output  reg dout = 1'b0;

always @(posedge clk) begin
  if(~rst_n) begin
     dout <= 0;
  end else if (din) begin
     dout <= ~dout;
  end
end
endmodule


module btn_clk (clk,rst_n,din,dout);
input wire clk;
input wire rst_n;
input wire din;
output wire dout;
endmodule


// 動いた
// ボタンを押すごとに対応するledがon off をする。
module led_switch_check (clk,rst_n,btn,led);
input   wire clk;
input   wire rst_n;
input   wire [4:0] btn;
output  wire [4:0] led;




  wire din;
  assign din = |btn;
  wire dout;

chattering i_chattering (.clk(clk), .rst_n(rst_n), .din(din), .dout(dout));

generate
  genvar i;
  for(i = 0; i < 5; i = i + 1)begin : switch
        switch i_switch (.clk(clk), .rst_n(rst_n), .din(btn[i] && dout), .dout(led[i]));
  end
endgenerate


endmodule


module byte_mux(data_in, sel, data_out);
input  wire [31:0] data_in;
input  wire [1:0]  sel;
output wire [7:0]  data_out;

assign data_out = (sel == 2'b00) ? data_in[ 7: 0] :
                  (sel == 2'b01) ? data_in[15: 8] :
                  (sel == 2'b10) ? data_in[23:16] :
                  data_in[31:24];
endmodule


module selector #(parameter WIDTH = 8)(
  input  wire  sl,    // Clock
  input  wire  [WIDTH-1:0] din0,
  input  wire  [WIDTH-1:0] din1,
  output wire  [WIDTH-1:0] dout
);

assign dout = sl ? din1 :din0;
endmodule

// メモリを選択して読む
module memory_controler
#(parameter ADDR_WIDTH = 8,
  parameter INTERBAL = 10)
(clk,rst_n,show_addr,sel,led,din,addr,en,up,down);

input  wire clk;
input  wire rst_n;
input  wire show_addr;
input  wire [1:0] sel;
output wire [7:0] led;
input  wire [31:0] din;
output wire [ADDR_WIDTH - 1:0] addr;
output wire en;
input  wire up;
input  wire down;


wire [7:0] dout;      // for counter
wire [7:0] data_out; // for bytemax

generate
  if(INTERBAL == 0) begin
    assign en = 1;
  end else begin
    reg [INTERBAL:0]  counter = 0;
    always @(posedge clk) begin
        counter  <= counter + 1;
    end

    assign en = (counter == 0);
  end

endgenerate



generate

if(ADDR_WIDTH < 8 ) begin

  assign addr[ADDR_WIDTH-1:0] = dout[ADDR_WIDTH-1:0];
end else begin

  assign addr[7:0] = dout;
  assign addr[ADDR_WIDTH-1:8] = 0;

end

endgenerate

assign led = show_addr ? dout : data_out;

btn_counter i_btn_counter (.clk(clk), .rst_n(rst_n), .up(up), .down(down), .dout(dout));

byte_mux i_byte_mux (.data_in(din), .sel(sel), .data_out(data_out));

endmodule


`default_nettype wire