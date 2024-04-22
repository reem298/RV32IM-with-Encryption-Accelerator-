module mult_radix8_tb (); parameter length =32;
  
  
  reg [length-1:0] OPER_A_tb,OPER_B_tb;
  reg  ENABLE_MULT_tb,FUCT3_tb;
  wire [length-1:0] MULT_O_tb;
  wire  MULT_FINISH_tb;
  
  
  mult_radix8_top DUT (
  .OPER_A(OPER_A_tb),
  .OPER_B(OPER_B_tb),
  .ENABLE_MULT(ENABLE_MULT_tb),
  .FUCT3(FUCT3_tb),
  .MULT_O(MULT_O_tb),
  .MULT_FINISH(MULT_FINISH_tb));
  
  
  
  
  initial 
  begin
    OPER_A_tb='b011;
    OPER_B_tb='b01000;
    ENABLE_MULT_tb='b0;
    FUCT3_tb='b0;
    
    #5   ENABLE_MULT_tb='b1;
    #5   FUCT3_tb='b1;
    #5 FUCT3_tb='b0;     OPER_A_tb=-'d8;      OPER_B_tb=-'d3;
    #5                   OPER_A_tb='d8;       OPER_B_tb=-'d3;
    #5 FUCT3_tb='b0;     OPER_A_tb=-'d8;      OPER_B_tb='d3;
    #5                   OPER_A_tb='d234;     OPER_B_tb='d277;
    #5                   OPER_A_tb=-'d234;    OPER_B_tb='d277;
    #5                   OPER_A_tb='d555;     OPER_B_tb='d555;
    #5          
  
    $finish;
  end
    
  
    
    
    
  
  
  
endmodule

