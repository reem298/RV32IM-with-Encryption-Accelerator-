module division #(parameter length=32)(DIV_interface.DUT divIF);
 
 logic signed [length-1:0] oper_a,oper_b;
 logic fuct3,enable_div;
 logic divided_by_zero;
 logic signed [length-1:0] div_o;
 logic div_finish;

assign oper_a= divIF.oper_a;
assign oper_b= divIF.oper_b;
assign fuct3= divIF.fuct3; 
assign enable_div= divIF.enable_div;
assign divIF.divided_by_zero= divided_by_zero;
assign divIF.div_o= div_o;
assign divIF.div_finish=div_finish; 



 integer n;
 
 
 logic [length-1:0] dividend,divisor;  
 logic pos_output;
 logic [length-1:0] A=0;
 logic [2*length-1:0] AQ;
 logic [length-1:0] temp_A;
 logic sign;
 
 always@(*)
 begin                         ////////converr from signed to unsigned 
   if(oper_a[length-1]&&oper_b[length-1])          //////if 2 input negative output s positve
     begin
     pos_output=1'b1;                        
     dividend= (~{oper_a})+1'b1;
     divisor= (~{oper_b})+1'b1;
   end
 else if(oper_a[length-1])          //////if 1 input negative output is negative
    begin
     pos_output=1'b0;
     dividend= (~{oper_a})+1'b1;
     divisor=oper_b;
   end
 else if
   (oper_b[length-1]) //////if 1 input negative output is negativ
    begin
     pos_output=1'b0;
     dividend=oper_a;
     divisor=(~{oper_b})+1'b1;
   end
 else           //////if 2 input postive output is postive
    begin
     pos_output=1'b1;
     dividend=oper_a;
     divisor=oper_b;
   end
   
  AQ={A,dividend}  ;    ///////put an initial value for A and dividend to make the flow chart
  for (n=0;n<32;n=n+1)
   begin
     AQ=AQ<<1;
     temp_A=AQ[2*length-1:length] -divisor;
     if(!temp_A[length-1])
       begin
         AQ[2*length-1:length]=temp_A;
         AQ[0]=1;
     end
     else
       begin
         AQ[0]=0;
       end
 end
 if(enable_div)
   begin
     if(oper_b=='b0)
       begin
         divided_by_zero='b1;
         div_finish='b1;
         div_o='b0;
       end
   else if (fuct3&&pos_output)              ///////instruction is div result pos
     begin
         divided_by_zero='b0;
         div_o=AQ[length-1:0];
         div_finish='b1;
       end
     else if(fuct3&&!pos_output)        ////instruction is div result neg
        begin
         divided_by_zero='b0;
         div_o=~AQ[length-1:0]+1;
         div_finish='b1;
       end
        else if(!fuct3&&pos_output)       ///////instruction is rem result is pos
        begin
         divided_by_zero='b0;
         div_o=AQ[2*length-1:length];
         div_finish='b1;
       end
       
     else
       begin
         divided_by_zero='b0;
         div_o=~AQ[2*length-1:length]+1;
         div_finish='b1;
       end
     end
     else
        begin
         divided_by_zero='b0;
         div_o='b0;
         div_finish='b0;
       end
       
 end
 endmodule
   

