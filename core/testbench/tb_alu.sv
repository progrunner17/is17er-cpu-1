
`timescale 1ns/1ps

`include "include.vh"

module tb_alu (); /* this is automatically generated */

	logic rstb;
	logic srst;
	logic clk;



	logic [31:0] op1;
	logic [31:0] op2;
	logic  [2:0] op_ctrl;
	logic        op_switch;
	logic [31:0] alu_result;
	logic [31:0] op_result;
	logic error; 


	alu inst_alu
		(
			.op1        (op1),
			.op2        (op2),
			.op_ctrl    (op_ctrl),
			.op_switch  (op_switch),
			.alu_result (alu_result)
		);


	initial begin
				  	#1;
 error = 0;
 op_switch = 0;
 op_ctrl = 0;
 op1 = -20;
 op2 = 2;
for (op_ctrl = 0; op_ctrl <= 3'b111; ) begin
  case (op_ctrl)
      `ALU_ADD : begin
          if(op_switch) begin
              op_result = $signed(op1) - $signed(op2);        
          end else begin
              op_result = $signed(op1) + $signed(op2);                                    
          end
      end
      `ALU_SLL: op_result = $signed(op1) << $signed(op2);
      `ALU_SLT: op_result = {31'b0,($signed(op1)<$signed(op2))};
      `ALU_SLTU:op_result = {31'b0,($unsigned(op1)<$unsigned(op2))};
      `ALU_XOR: op_result = op1 ^ op2;
      `ALU_SRX: if(op_switch) begin
              op_result = $signed(op1) >>> op2[4:0];
      end else begin
              op_result = $signed(op1) >> op2[4:0];
      end
      `ALU_OR: op_result = op1 || op2;
      `ALU_AND: op_result = op1 && op2;
  endcase

  #1;
  if(alu_result == op_result) begin
      error = 0;
  end else begin
      error = 1;
  end

  if((op_ctrl == `ALU_ADD || op_ctrl == `ALU_SRX )&& op_switch == 0)begin
      op_switch = 1;
  end else if (op_ctrl != 3'b111)begin 
      op_ctrl = op_ctrl + 1;
      op_switch = 0;
  end else  begin
   break; 
  end
  
end

	
	
    
		repeat(100)begin
			  	#1;
			   error = 0;
			   op_switch = 0;
			   op_ctrl = 0;
			   op1 = $random();
			   op2 = $random();
			for (op_ctrl = 0; op_ctrl <= 3'b111; ) begin
				case (op_ctrl)
					`ALU_ADD : begin
						if(op_switch ) begin
							op_result = $signed(op1) - $signed(op2);		
						end else begin
							op_result = $signed(op1) + $signed(op2);									
						end
					end
					`ALU_SLL: op_result = $signed(op1) << $signed(op2);
					`ALU_SLT: op_result = {31'b0,($signed(op1)<$signed(op2))};
					`ALU_SLTU:op_result = {31'b0,($unsigned(op1)<$unsigned(op2))};
					`ALU_XOR: op_result = op1 ^ op2;
					`ALU_SRX: if(op_switch) begin
							op_result = $signed(op1) >>> $signed(op2);
					end else begin
							op_result = $signed(op1) >> $signed(op2);
					end
					`ALU_OR: op_result = op1 || op2;
					`ALU_AND: op_result = op1 && op2;
				endcase

				#1;
				if(alu_result == op_result) begin
					error = 0;
				end else begin
					error = 1;
				end

				if((op_ctrl == `ALU_ADD || op_ctrl == `ALU_SRX )&& op_switch == 0)begin
					op_switch = 1;
				end else if (op_ctrl != 3'b111)begin 
				    op_ctrl = op_ctrl + 1;
				    op_switch = 0;
				end else  begin
				 break; 
				end
				
			end
		end

		$finish;
	end

endmodule
