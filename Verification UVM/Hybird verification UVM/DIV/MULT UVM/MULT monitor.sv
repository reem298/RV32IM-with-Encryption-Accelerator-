//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT monitor

package MULT_monitor;
	import MULT_seq_item::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

class mult_monitor extends uvm_monitor;
  `uvm_component_utils(mult_monitor)
   virtual MULT_interface mult_monitor_vif;
	mult_seq_item rsp_seq_item;
	uvm_analysis_port #(mult_seq_item) mon_ap;
//constructor
function new (string name = "mult_monitor", uvm_component parent = null);
 super.new(name, parent);
endfunction

//build phase
function void build_phase (uvm_phase phase);
 super.build_phase(phase);
	mon_ap = new("mon_ap", this);
endfunction : build_phase

//runphase
task run_phase(uvm_phase phase);
			super.run_phase(phase);
			forever begin 
				#10;
				rsp_seq_item = mult_seq_item::type_id::create("rsp_seq_item");
				rsp_seq_item.OPER_A 	= mult_monitor_vif.OPER_A;
				rsp_seq_item.OPER_B		= mult_monitor_vif.OPER_B;
				rsp_seq_item.ENABLE_MULT= mult_monitor_vif.ENABLE_MULT;
				rsp_seq_item.FUCT3 	    = mult_monitor_vif.FUCT3;
				rsp_seq_item.MULT_O 	= mult_monitor_vif.MULT_O;
				rsp_seq_item.MULT_FINISH= mult_monitor_vif.MULT_FINISH;
				mon_ap.write(rsp_seq_item);
				`uvm_info("run_phase", rsp_seq_item.convert2string(), UVM_HIGH)
			end
		endtask : run_phase
	endclass : mult_monitor

endpackage