
class apb_agent_top extends uvm_agent;
	`uvm_component_utils(apb_agent_top)
	apb_agent apb_agenth;
	env_config env_cfg;
	apb_config apb_cfg;

	//-------------------------------
	//--------METHODS----------------
	//-------------------------------
	extern function new(string name="apb_agent_top",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass

function apb_agent_top::new(string name="apb_agent_top",uvm_component parent);
	super.new(name,parent);
endfunction
function void apb_agent_top::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
		`uvm_fatal(get_type_name(),"can't get the env config")
	uvm_config_db#(apb_config)::set(this,"*","apb_config",env_cfg.apb_cfg);

	apb_agenth=apb_agent::type_id::create("apb_agenth",this);
endfunction
