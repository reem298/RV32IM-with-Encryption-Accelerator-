//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT sequence item

package MULT_seq_item;
import uvm_pkg::*;
`include "uvm_macros.svh"

class mult_seq_item extends uvm_sequence_item;
`uvm_object_utils(mult_seq_item)

parameter length =32;
rand bit signed [length-1:0] OPER_A,OPER_B;
rand bit signed ENABLE_MULT,FUCT3;
bit signed [length-1:0] MULT_O;
bit  MULT_FINISH;

//constraints
/*constraint funct3 { 
FUCT3 dist {0:=50, 1:=50};
}; */


//consturctor
function new (string name = "mult_seq_item");
	super.new(name);
endfunction

function string convert2string();
	return $sformatf("%s OPER_A = 0h%0h, OPER_B = 0h%0h, ENABLE_MULT = 0h%0h, FUCT3= 0h%0h, MULT_O=0h%0h", super.convert2string, OPER_A, OPER_B, ENABLE_MULT,FUCT3,MULT_O);
endfunction : convert2string

function string convert2string_stimulus();
			return $sformatf(" OPER_A = 0h%0h, OPER_B = 0h%0h, ENABLE_MULT =0h%0h, FUCT3= 0h%0h,MULT_O=0h%0h", OPER_A, OPER_B, ENABLE_MULT,FUCT3,MULT_O);
endfunction : convert2string_stimulus

endclass : mult_seq_item	

endpackage : MULT_seq_item	