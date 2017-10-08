`default_nettype none


module chattering
  ( input wire clk,rstn,
    input wire data,
    output reg outdata);
    
  reg [25:0] count;

  always @(posedge clk) begin 
    if(~rstn) begin 
        count <= 6'b0;
        outdata <= 1'b0;
    end else begin 
        if(~data)begin 
            outdata <= 1'b0;
            count <= 1'b0;
         end else begin
            count <= count + 1;
         end
    end 
    if(count==26'h0200000) outdata <= 1'b1;  
    else outdata <= 1'b0;
  end 

endmodule

`default_nettype wire