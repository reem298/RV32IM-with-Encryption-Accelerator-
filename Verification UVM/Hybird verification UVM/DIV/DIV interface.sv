//div of RV32IM verification uvm
//Author: reem ahmed 
// DIV interface

interface DIV_interface();

parameter length =32;
 logic signed [length-1:0] oper_a,oper_b;
 logic fuct3,enable_div;
 logic divided_by_zero;
 logic signed [length-1:0] div_o;
 logic div_finish;

modport TEST (output oper_a,oper_b,fuct3,enable_div,input divided_by_zero,div_o,div_finish );

modport DUT (input oper_a,oper_b,fuct3,enable_div,output divided_by_zero,div_o,div_finish );

modport Monitor (input oper_a,oper_b,fuct3,enable_div,divided_by_zero,div_o,div_finish );


endinterface 	