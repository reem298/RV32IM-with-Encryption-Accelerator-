//div of RV32IM verification uvm
//Author: reem ahmed
// DIV coverage collector

package DIV_coverage_collector;
import DIV_seq_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class div_coverage extends uvm_component;
`uvm_component_utils(div_coverage)
uvm_analysis_export #(div_seq_item) cov_export;
uvm_tlm_analysis_fifo #(div_seq_item) cov_fifo;

div_seq_item seq_item_cov;

covergroup cg();
oper_a: coverpoint seq_item_cov.oper_a;
oper_b: coverpoint seq_item_cov.oper_b;
enable_div: coverpoint seq_item_cov.enable_div;
fuct3: coverpoint seq_item_cov.fuct3;
divided_by_zero: coverpoint seq_item_cov.divided_by_zero;
div_o: coverpoint seq_item_cov.div_o;
div_finish: coverpoint seq_item_cov.div_finish;
//cross coverage
cross fuct3,div_o;
cross enable_div,div_o,div_finish;

endgroup : cg	

//constructor
function new (string name = "div_coverage", uvm_component parent = null);
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



endclass : div_coverage	

endpackage : DIV_coverage_collector	