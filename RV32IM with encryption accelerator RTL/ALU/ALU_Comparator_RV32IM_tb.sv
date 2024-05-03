module ALU_Comparator_Testbench;
  // Parameters
  parameter data_width = 32;

  // Inputs
  logic signed [data_width-1:0] operand_A;
  logic signed [data_width-1:0] operand_B;

  // Outputs
  logic Greater;
  logic Equal;
  logic Less;

  // Instantiate the ALU_Comparator module
  ALU_Comparator #(data_width) uut(
    .operand_A(operand_A),
    .operand_B(operand_B),
    .Greater(Greater),
    .Equal(Equal),
    .Less(Less)
  );


  // Testbench logic
  initial begin
    // Initialize inputs
    operand_A = 0;
    operand_B = 0;

    // Wait for some time for stability
    #10;

    // Test case 1: directed test
    operand_A = 5;
    operand_B = 3;
    #10;
    $display("Test case 1: operand_A = %d, operand_B = %d", operand_A, operand_B);
    $display("Greater = %b, Equal = %b, Less = %b", Greater, Equal, Less);

    // Test case 2: randomized test
 
   repeat(1000)begin
     operand_A=$random;
     operand_B=$random;
       #10;
    $display("Test case 1: operand_A = %d, operand_B = %d", operand_A, operand_B);
    $display("Greater = %b, Equal = %b, Less = %b", Greater, Equal, Less);  
   end   

endmodule