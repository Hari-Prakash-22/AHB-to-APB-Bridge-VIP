class base_test extends uvm_test;
	`uvm_component_utils(base_test);
	ahb_config ahb_cfg;
	apb_config apb_cfg;
	env_config env_cfg;
	env env_h;
//	virtual_sequence v_seqh;
	bit has_ahb_agent=1;
	bit has_apb_agent=1;
	bit has_scoreboard=1;
	bit has_virtual_sequencer=1;
	
	//--------------------------
	//---------METHODS---------
	//-------------------------
	extern function new(string name="base_test",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	//extern function void report_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass

function base_test::new(string name="base_test",uvm_component parent);
	super.new(name,parent);
endfunction


function void base_test::build_phase(uvm_phase phase);
	super.build_phase(phase);


	env_cfg=env_config::type_id::create("env_cfg");
	if(has_ahb_agent)
	begin
		ahb_cfg=ahb_config::type_id::create("ahb_cfg");
		ahb_cfg.is_active=UVM_ACTIVE;
		if(!uvm_config_db#(virtual bridge_if)::get(this,"","ahb_if",ahb_cfg.vif))
			`uvm_fatal(get_type_name(),"can't get the interface")
			env_cfg.ahb_cfg=ahb_cfg;
	end
	if(has_apb_agent)
	begin
		apb_cfg=apb_config::type_id::create("apb_cfg");
		apb_cfg.is_active=UVM_ACTIVE;

		if(!uvm_config_db#(virtual bridge_if)::get(this,"","apb_if",apb_cfg.vif))
			`uvm_fatal(get_type_name(),"can't get the interface")
	
		env_cfg.apb_cfg=apb_cfg;
	end
	env_cfg.has_ahb_agent=has_ahb_agent;
	env_cfg.has_apb_agent=has_apb_agent;
	env_cfg.has_scoreboard=has_scoreboard;
	env_cfg.has_virtual_sequencer=has_virtual_sequencer;
	uvm_config_db#(env_config)::set(this,"*","env_config",env_cfg);
	env_h=env::type_id::create("env_h",this);
//	if(has_virtal_sequencer)
//	begin
//		v_seqh=virtual_sequence::type_id::create("v_seqh");
//	end
	
endfunction


task base_test::run_phase(uvm_phase phase);
	super.run_phase(phase);
endtask
/*function void base_test::report_phase(uvm_phase phase);
	super.report_phase(phase);
	uvm_top.print_topology();
endfunction*/


class test1 extends base_test;

	`uvm_component_utils(test1)
	
	virtual_incr_seq seq1_h;


	extern function new(string name = "test1",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass
function test1::new(string name="test1",uvm_component parent);
	super.new(name,parent);
endfunction
function void test1::build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction
task test1::run_phase(uvm_phase phase);
	super.run_phase(phase);
	begin
	seq1_h=virtual_incr_seq::type_id::create("seq1_h");
	phase.raise_objection(this);
		seq1_h.start(env_h.v_seqrh);
	#120;
	phase.drop_objection(this);
	
	end
	
endtask
class wrap4_test extends base_test;

	`uvm_component_utils(wrap4_test)
	
	virtual_wrap4_seq wrap4_seq_h;


	extern function new(string name = "warp4_test",uvm_component parent);
//	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass
function wrap4_test::new(string name="warp4_test",uvm_component parent);
	super.new(name,parent);
endfunction
task wrap4_test::run_phase(uvm_phase phase);
	super.run_phase(phase);
	begin
	wrap4_seq_h=virtual_wrap4_seq::type_id::create("wrap4_seq_h");
	phase.raise_objection(this);
		wrap4_seq_h.start(env_h.v_seqrh);
	#120;
	phase.drop_objection(this);
	end
	
endtask
class single_test extends base_test;

	`uvm_component_utils(single_test)
	
	virtual_single_seq single_seq_h;


	extern function new(string name = "single_test",uvm_component parent);
//	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass
function single_test::new(string name="single_test",uvm_component parent);
	super.new(name,parent);
endfunction
task single_test::run_phase(uvm_phase phase);
	super.run_phase(phase);
	begin
	single_seq_h=virtual_single_seq::type_id::create("single_seq_h");
	phase.raise_objection(this);
		single_seq_h.start(env_h.v_seqrh);
	#120;
	phase.drop_objection(this);
	end
	
endtask
