//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT interface

interface MULT_interface();

parameter length =32;
logic signed [length-1:0] OPER_A,OPER_B;
logic  ENABLE_MULT,FUCT3;
logic signed [length-1:0] MULT_O;
logic  MULT_FINISH;

modport TEST (output OPER_A, OPER_B, ENABLE_MULT, FUCT3,input  MULT_O, MULT_FINISH);

modport DUT (input OPER_A, OPER_B, ENABLE_MULT, FUCT3,output  MULT_O, MULT_FINISH);

modport Monitor (input OPER_A, OPER_B, ENABLE_MULT, FUCT3, MULT_O, MULT_FINISH);


endinterface : MULT_interface	