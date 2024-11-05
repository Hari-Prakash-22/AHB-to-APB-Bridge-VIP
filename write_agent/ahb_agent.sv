
class ahb_agent extends uvm_agent;
	`uvm_component_utils(ahb_agent)
	ahb_driver ahb_drvh;
	ahb_monitor ahb_monh;
	ahb_sequencer ahb_seqrh;
	ahb_config ahb_cfg;

	//-------------------------------
	//--------METHODS----------------
	//-------------------------------
	extern function new(string name="ahb_agent",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass

function ahb_agent::new(string name="ahb_agent",uvm_component parent);
	super.new(name,parent);
endfunction
function void ahb_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(ahb_config)::get(this,"","ahb_config",ahb_cfg))
		`uvm_fatal(get_type_name(),"can't get the env config")

	ahb_monh=ahb_monitor::type_id::create("ahb_monh",this);
	if(ahb_cfg.is_active==UVM_ACTIVE)
	begin
	ahb_drvh=ahb_driver::type_id::create("ahb_drvhh",this);
	ahb_seqrh=ahb_sequencer::type_id::create("ahb_seqrh",this);
	end
endfunction
function void ahb_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	ahb_drvh.seq_item_port.connect(ahb_seqrh.seq_item_export);
endfunction
