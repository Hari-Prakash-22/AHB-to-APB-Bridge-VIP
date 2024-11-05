
class ahb_agent_top extends uvm_agent;
	`uvm_component_utils(ahb_agent_top)
	ahb_agent ahb_agenth;
	env_config env_cfg;
	ahb_config ahb_cfg;
	

	//-------------------------------
	//--------METHODS----------------
	//-------------------------------
	extern function new(string name="ahb_agent_top",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass

function ahb_agent_top::new(string name="ahb_agent_top",uvm_component parent);
	super.new(name,parent);
endfunction
function void ahb_agent_top::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
		`uvm_fatal(get_type_name(),"can't get the env config")
	uvm_config_db#(ahb_config)::set(this,"*","ahb_config",env_cfg.ahb_cfg);
	ahb_agenth=ahb_agent::type_id::create("ahb_agenth",this);
endfunction
