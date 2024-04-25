//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT sequence item

package MULT_seq_item;
import uvm_pkg::*;
`include "uvm_macros.svh"

class mult_seq_item extends uvm_sequence_item;
`uvm_object_utils(mult_seq_item)

parameter length =32;
rand bit [length-1:0] OPER_A,OPER_B;
rand bit  ENABLE_MULT,FUCT3;
bit [length-1:0] MULT_O;
bit  MULT_FINISH;

//constraints
constraint funct3 { 
FUCT3 dist {0:=50, 1:=50};
};
//
//
//
//

//consturctor
function new (string name = "mult_seq_item");
	super.new(name);
endfunction

function string convert2string();
	return $sformatf("%s OPER_A = 0b%0b, OPER_B = 0b%0b, ENABLE_MULT = 0b%0b, FUCT3= 0b%0b", super.convert2string, OPER_A, OPER_B, ENABLE_MULT,FUCT3);
endfunction : convert2string

function string convert2string_stimulus();
			return $sformatf(" OPER_A = 0b%0b, OPER_B = 0b%0b, ENABLE_MULT = 0b%0b, FUCT3= 0b%0b", OPER_A, OPER_B, ENABLE_MULT,FUCT3);
endfunction : convert2string_stimulus

endclass : mult_seq_item	

endpackage : MULT_seq_item	