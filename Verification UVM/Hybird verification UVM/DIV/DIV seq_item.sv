//div of RV32IM verification uvm
//Author: reem ahmed
// DIV sequence item

package DIV_seq_item;
import uvm_pkg::*;
`include "uvm_macros.svh"

class div_seq_item extends uvm_sequence_item;
`uvm_object_utils(div_seq_item)

parameter length =32;
rand bit signed [length-1:0] oper_a,oper_b;
rand bit fuct3,enable_div;
bit divided_by_zero;
bit signed [length-1:0] div_o;
bit div_finish;

/* constraints
constraint funct3 { 
fuct3 dist {0:=50, 1:=50};
};
*/


//consturctor
function new (string name = "div_seq_item");
	super.new(name);
endfunction

function string convert2string();
	return $sformatf("%s oper_a = 0h%0h, oper_b = 0h%0h, enable_div = 0h%0h, fuct3= 0h%0h, div_o=0h%0h", super.convert2string, oper_a, oper_b, enable_div,fuct3, div_o);
endfunction : convert2string

function string convert2string_stimulus();
			return $sformatf(" oper_a= 0h%0h, oper_b= 0h%0h, enable_div=0h%0h, fuct3= 0h%0h, div_o=0h%0h", oper_a, oper_b, enable_div,fuct3, div_o);
endfunction : convert2string_stimulus

endclass : div_seq_item	

endpackage : DIV_seq_item	