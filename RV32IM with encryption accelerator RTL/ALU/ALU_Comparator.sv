//comparator of ALU_RV32IM 
//Author: reem ahmed ali
// 32-Bit Magnitude Comparator Using subtraction
module ALU_Comparator #(parameter data_width = 32)
(input logic  signed [data_width-1:0] operand_A,operand_B,output logic Greater,Equal,Less);

  // Internal signals
  logic signed [31:0] difference;

  // Calculate the difference between A and B
  always_comb begin
    difference = operand_B - operand_A;
    //outputs
    Equal = (difference===0);
    Greater = (difference[31] === 1); //negative result, operand_A is Greater than operand_B
    Less = (difference[31] == 0) && (Equal===0); //positive result, operand_A is Less than operand_B
  end
 endmodule   


