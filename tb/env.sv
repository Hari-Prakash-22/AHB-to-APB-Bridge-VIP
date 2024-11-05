
class env extends uvm_agent;
	`uvm_component_utils(env)
	apb_agent_top apb_agent_toph;
	ahb_agent_top ahb_agent_toph;
	env_config env_cfg;
	scoreboard sb_h;
	virtual_sequencer v_seqrh;

	//-------------------------------
	//--------METHODS----------------
	//-------------------------------
	extern function new(string name="env",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass

function env::new(string name="env",uvm_component parent);
	super.new(name,parent);
endfunction
function void env::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
		`uvm_fatal(get_type_name(),"can't get the env config db ")
	if(env_cfg.has_apb_agent)
	begin
	apb_agent_toph=apb_agent_top::type_id::create("apb_agent_toph",this);
	end
	if(env_cfg.has_ahb_agent)
	begin
	ahb_agent_toph=ahb_agent_top::type_id::create("ahb_agent_toph",this);
	end
	if(env_cfg.has_scoreboard)
	begin
	sb_h=scoreboard::type_id::create("sb_h",this);
	end
	if(env_cfg.has_virtual_sequencer)
	begin
	v_seqrh=virtual_sequencer::type_id::create("v_seqrh",this);
	end
endfunction
function void env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	v_seqrh.ahb_seqrh=ahb_agent_toph.ahb_agenth.ahb_seqrh;
	v_seqrh.apb_seqrh=apb_agent_toph.apb_agenth.apb_seqrh;
	ahb_agent_toph.ahb_agenth.ahb_monh.ahb_monitor_port.connect(sb_h.ahb_monitor_xtn.analysis_export);
	apb_agent_toph.apb_agenth.apb_monh.apb_monitor_port.connect(sb_h.apb_monitor_xtn.analysis_export);
	
endfunction

