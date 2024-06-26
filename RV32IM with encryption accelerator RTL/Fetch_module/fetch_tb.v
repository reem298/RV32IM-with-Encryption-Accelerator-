`timescale 1ns/1ns

module fetch_tb ();
  
  reg             clk, rst;
  reg     [1:0]   pc_s_in;
  reg     [31:0]  pc_dec_in , pc_alu_in;
  wire    [31:0]  pc_out ;
  wire    [31:0]  pc_plus4 ;
  
  initial 
  begin
    
    //initial values
    clk          = 'b0    ;
    rst          = 'b0    ;
    pc_s_in      = 'b0    ;
    pc_dec_in = 'b11111   ;
    pc_alu_in = 'b10001 ;
    #7
    rst = 1'b1    ;
    #38
    pc_s_in      = 'b01    ;
    #10
    pc_s_in      = 'b00    ;
    #50
    pc_s_in      = 'b10    ;
    #10
    pc_s_in      = 'b00    ;
    #50
    pc_s_in      = 'b11    ;
    #10
    pc_s_in      = 'b00    ;
  #500        
  
    $finish;
  end
  
  // Clock Generator  
  always #5 clk = !clk ;
  
    fetch_cycle DUT (
  .clk(clk),
  .rst(rst),
  .pc_s_in(pc_s_in),
  .pc_dec_in(pc_dec_in),
  .pc_alu_in(pc_alu_in),
  .pc_out(pc_out),
  .pc_plus4(pc_plus4)
  );
  
endmodule

