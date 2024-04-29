//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT driver

package MULT_driver;
import uvm_pkg::*;
import MULT_seq_item::*;
`include "uvm_macros.svh"

class mult_driver extends uvm_driver#(mult_seq_item);
`uvm_component_utils(mult_driver)
virtual MULT_interface mult_driver_vif;
mult_seq_item stim_seq_item;

//constructor
function new (string name = "mult_driver", uvm_component parent = null);
	super.new(name, parent);
endfunction

//run phase
task run_phase(uvm_phase phase);
 super.run_phase(phase);	
	forever begin 
		stim_seq_item = mult_seq_item::type_id::create("stim_seq_item");
		seq_item_port.get_next_item(stim_seq_item);
		mult_driver_vif.OPER_A = stim_seq_item.OPER_A;
		mult_driver_vif.OPER_B = stim_seq_item.OPER_B; 	
		mult_driver_vif. ENABLE_MULT = stim_seq_item. ENABLE_MULT; 
		mult_driver_vif. FUCT3 = stim_seq_item.FUCT3 ; 
		#10;
		seq_item_port.item_done();
		`uvm_info("run_phase", stim_seq_item.convert2string_stimulus(), UVM_HIGH)
		end
	endtask : run_phase

endclass : mult_driver	


endpackage : MULT_driver	