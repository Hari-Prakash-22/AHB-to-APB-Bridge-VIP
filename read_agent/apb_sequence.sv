class apb_sequence extends uvm_sequence#(apb_xtn);
	`uvm_object_utils(apb_sequence)


	//-------------------------------
	//--------METHODS----------------
	//-------------------------------
	extern function new(string name="apb_sequence");
endclass

function apb_sequence::new(string name="apb_sequence");
	super.new(name);
endfunction
