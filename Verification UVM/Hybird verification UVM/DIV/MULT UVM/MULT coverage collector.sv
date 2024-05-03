//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT coverage collector

package MULT_coverage_collector;
import MULT_seq_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class mult_coverage extends uvm_component;
`uvm_component_utils(mult_coverage)
uvm_analysis_export #(mult_seq_item) cov_export;
uvm_tlm_analysis_fifo #(mult_seq_item) cov_fifo;

mult_seq_item seq_item_cov;

covergroup cg();
OPER_A: coverpoint seq_item_cov.OPER_A;
OPER_B: coverpoint seq_item_cov.OPER_B;
ENABLE_MULT: coverpoint seq_item_cov.ENABLE_MULT;
FUCT3: coverpoint seq_item_cov.FUCT3;
MULT_O: coverpoint seq_item_cov.MULT_O;
MULT_FINISH: coverpoint seq_item_cov.MULT_FINISH;
//cross coverage
cross FUCT3,MULT_O;
cross ENABLE_MULT,MULT_FINISH;

endgroup : cg	

//constructor
function new (string name = "mult_coverage", uvm_component parent = null);
 super.new(name, parent);
	cg = new;
endfunction

//build phase
function void build_phase (uvm_phase phase);
  super.build_phase(phase);
  cov_export = new("cov_export", this);
  cov_fifo = new("cov_fifo", this);
endfunction :  build_phase

//connect phase
function void connect_phase (uvm_phase phase);
  super.connect_phase(phase);
 cov_export.connect(cov_fifo.analysis_export);
endfunction : connect_phase

//run phase
task run_phase(uvm_phase phase);
 super.run_phase(phase);
	forever begin 
	 cov_fifo.get(seq_item_cov);
	 cg.sample();
			end
endtask : run_phase



endclass : mult_coverage	

endpackage : MULT_coverage_collector	