module mult_radix8_top #(parameter length=32)(
  input wire [length-1:0] OPER_A,OPER_B,
  input wire  ENABLE_MULT,FUCT3,
  output wire [length-1:0] MULT_O,
  output wire  MULT_FINISH);
  
  
  wire  [length:0] partial1_booth, partial2_booth, partial3_booth, partial4_booth;
   wire  [length:0] partial5_booth, partial6_booth, partial7_booth, partial8_booth;   
   wire  [length:0] partial9_booth, partial10_booth, partial11_booth, partial12_booth;
   wire  [length:0] partial13_booth, partial14_booth, partial15_booth, partial16_booth;

   
   
  
  
  
  booth b1 (
  .oper_a(OPER_A),
  .oper_b(OPER_B),
  .enable_mult(ENABLE_MULT),
  .partial1_booth(partial1_booth),
  .partial2_booth(partial2_booth),
  .partial3_booth(partial3_booth),
  .partial4_booth(partial4_booth),
  .partial5_booth(partial5_booth),
  .partial6_booth(partial6_booth),
  .partial7_booth(partial7_booth),
  .partial8_booth(partial8_booth),
  .partial9_booth(partial9_booth),
  .partial10_booth(partial10_booth),
  .partial11_booth(partial11_booth),
  .partial12_booth(partial12_booth),
  .partial13_booth(partial13_booth),
  .partial14_booth(partial14_booth),
  .partial15_booth(partial15_booth),
  .partial16_booth(partial16_booth));
  
  
  
  mult_radix8 m1 (
  .partial1_booth(partial1_booth),
  .partial2_booth(partial2_booth),
  .partial3_booth(partial3_booth),
  .partial4_booth(partial4_booth),
  .partial5_booth(partial5_booth),
  .partial6_booth(partial6_booth),
  .partial7_booth(partial7_booth),
  .partial8_booth(partial8_booth),
  .partial9_booth(partial9_booth),
  .partial10_booth(partial10_booth),
  .partial11_booth(partial11_booth),
  .partial12_booth(partial12_booth),
  .partial13_booth(partial13_booth),
  .partial14_booth(partial14_booth),
  .partial15_booth(partial15_booth),
  .partial16_booth(partial16_booth),
  .enable_mult(ENABLE_MULT),
  .fuct3(FUCT3),
  .mult_o(MULT_O),
  .mult_finish(MULT_FINISH));
  
  
endmodule
