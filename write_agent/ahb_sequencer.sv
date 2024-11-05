class ahb_sequencer extends uvm_sequencer#(ahb_xtn);
	`uvm_component_utils(ahb_sequencer);



	//--------------------------
	//---------METHODS---------
	//-------------------------
	extern function new(string name="ahb_sequencer",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function ahb_sequencer::new(string name="ahb_sequencer",uvm_component parent);
	super.new(name,parent);
endfunction


function void ahb_sequencer::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction


task ahb_sequencer::run_phase(uvm_phase phase);
	super.run_phase(phase);
endtask

