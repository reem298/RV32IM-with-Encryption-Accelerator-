module Mux (a,b,c,s,d);
    input        [31:0]  a,b,c;
    input        [1:0]   s;
    output       [31:0]  d;

  
    assign d = (s == 2'b11) ? 'h98 : (s == 2'b00) ? a : (s == 2'b01) ? b : (s == 2'b10) ? c : 'b0 ;
    
endmodule

