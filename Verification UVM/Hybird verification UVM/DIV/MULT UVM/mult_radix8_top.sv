module mult_radix8_top #(parameter length=32)(MULT_interface.DUT multIF);
  
   logic signed [length-1:0] OPER_A,OPER_B;
   logic  ENABLE_MULT,FUCT3;
   logic signed [length-1:0] MULT_O;
   logic  MULT_FINISH;

   assign OPER_A= multIF.OPER_A;
   assign OPER_B= multIF.OPER_B;
   assign ENABLE_MULT=multIF.ENABLE_MULT;
   assign multIF.MULT_O= MULT_O;
   assign multIF.MULT_FINISH=MULT_FINISH;
  
   logic  [length:0] partial1_booth, partial2_booth, partial3_booth, partial4_booth;
   logic  [length:0] partial5_booth, partial6_booth, partial7_booth, partial8_booth;   
   logic  [length:0] partial9_booth, partial10_booth, partial11_booth, partial12_booth;
   logic [length:0] partial13_booth, partial14_booth, partial15_booth, partial16_booth;

   
   
  
  
  
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
