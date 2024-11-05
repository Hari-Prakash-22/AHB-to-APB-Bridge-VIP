class apb_agent extends uvm_agent;
	`uvm_component_utils(apb_agent)
	apb_driver apb_drvh;
	apb_monitor apb_monh;
	apb_sequencer apb_seqrh;
	apb_config apb_cfg;

	//-------------------------------
	//--------METHODS----------------
	//-------------------------------
	extern function new(string name="apb_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass

function apb_agent::new(string name="apb_agent",uvm_component parent);
	super.new(name,parent);
endfunction
function void apb_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
		if(!uvm_config_db#(apb_config)::get(this,"","apb_config",apb_cfg))
		`uvm_fatal(get_type_name(),"can't get the env config")

	apb_monh=apb_monitor::type_id::create("apb_monh",this);
	if(apb_cfg.is_active==UVM_ACTIVE)
	begin
	apb_drvh=apb_driver::type_id::create("apb_drvhh",this);
	apb_seqrh=apb_sequencer::type_id::create("apb_seqrh",this);
	end
endfunction
