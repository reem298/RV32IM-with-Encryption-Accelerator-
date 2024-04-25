module booth #(parameter length=32)(
  input logic signed [length-1:0] oper_a,  // input a
  input logic signed [length-1:0] oper_b,  // input b
  input logic enable_mult,
  output logic signed [length:0] partial1_booth, partial2_booth, partial3_booth, partial4_booth,
  output logic signed [length:0] partial5_booth, partial6_booth, partial7_booth, partial8_booth,   
  output logic signed [length:0] partial9_booth, partial10_booth, partial11_booth, partial12_booth,
  output logic signed [length:0] partial13_booth, partial14_booth, partial15_booth, partial16_booth  // partial product
);
  
  wire [length:0] pos, neg, pos2, neg2, condition;
  
  assign pos = {oper_a[length-1], oper_a};
  assign neg = ~{oper_a[length-1], oper_a} + 1;
  assign pos2 = {pos[length-1:0], 1'b0};
  assign neg2 = {neg[length-1:0], 1'b0};
  assign condition = {oper_b, 1'b0};        //// put oper b in 33bit to apply radix 4 on it
  
  reg [length:0] booth_o;  // booth output
  reg [2:0] b;       //////////radix4 bits
  
  integer i;
   
  always @(*)
  begin
     partial1_booth = 'b0;
     partial2_booth = 'b0;
     partial3_booth = 'b0;
     partial4_booth = 'b0;
     partial5_booth = 'b0;
     partial6_booth = 'b0;  
     partial7_booth = 'b0;  
     partial8_booth = 'b0;
     partial9_booth = 'b0;
     partial10_booth = 'b0;
     partial11_booth = 'b0;
     partial12_booth = 'b0;
     partial13_booth = 'b0;
     partial14_booth = 'b0;
     partial15_booth = 'b0;
     partial16_booth = 'b0;
     
     if(enable_mult)                 
       begin
    for (i = 1; i < 32; i = i + 2)
    begin
      b = {condition[i+1], condition[i], condition[i-1]};     /// radix4 bits
      case (b)
        'b000: booth_o = 0;
        'b001: booth_o = pos;
        'b010: booth_o = pos;
        'b011: booth_o = pos2;
        'b100: booth_o = neg2;
        'b101: booth_o = neg;
        'b110: booth_o = neg;
        'b111: booth_o = 0;
        default: booth_o = 0;
      endcase 
      case (i)                // Assign booth_o to  make partial product register
        1: partial1_booth = booth_o;
        3: partial2_booth = booth_o;
        5: partial3_booth = booth_o;
        7: partial4_booth = booth_o;
        9: partial5_booth = booth_o;
        11: partial6_booth = booth_o;
        13: partial7_booth = booth_o;
        15: partial8_booth = booth_o;
        17: partial9_booth = booth_o;
        19: partial10_booth = booth_o;       
        21: partial11_booth = booth_o;
        23: partial12_booth = booth_o;
        25: partial13_booth = booth_o;
        27: partial14_booth = booth_o;
        29: partial15_booth = booth_o;
        31: partial16_booth = booth_o; 
        default: partial1_booth = 'b0;
      endcase
    end
  end
  else
    begin
     partial1_booth = 'b0;
     partial2_booth = 'b0;
     partial3_booth = 'b0;
     partial4_booth = 'b0;
     partial5_booth = 'b0;
     partial6_booth = 'b0;  
     partial7_booth = 'b0;  
     partial8_booth = 'b0;
     partial9_booth = 'b0;
     partial10_booth = 'b0;
     partial11_booth = 'b0;
     partial12_booth = 'b0;
     partial13_booth = 'b0;
     partial14_booth = 'b0;
     partial15_booth = 'b0;
     partial16_booth = 'b0;
     end
     end
endmodule

