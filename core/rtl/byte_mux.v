`default_nettype none

module byte_mux( input wire [31:0] data_in,
                 input wire [1:0]  sel,
                 output wire [7:0] data_out );

   assign data_out = (sel == 2'b00) ? data_in[7:0] :
		     (sel == 2'b01) ? data_in[15:8] :
		     (sel == 2'b10) ? data_in[23:16] : data_in[31:24];

endmodule

`default_nettype wire