class virtual_sequence extends uvm_sequence #(uvm_sequence_item);
	`uvm_object_utils(virtual_sequence)


	virtual_sequencer v_seqrh;
	ahb_sequencer ahb_seqrh; 
	apb_sequencer apb_seqrh; 

	extern function new(string name="virtual_sequence");
	extern task body();
endclass

function virtual_sequence::new(string name="virtual_sequence");
	super.new(name);
endfunction
task virtual_sequence::body();
	if(!$cast(v_seqrh,m_sequencer))
	begin
		`uvm_error(get_type_name(),"pointer cast failed")
	end
	ahb_seqrh=v_seqrh.ahb_seqrh;
	apb_seqrh=v_seqrh.apb_seqrh;
endtask

class virtual_incr_seq extends virtual_sequence;
	`uvm_object_utils(virtual_incr_seq)

	incr_seq incr_seqh;
	extern function new(string name="virtual_incr_seq");
	extern task body();
endclass

function virtual_incr_seq::new(string name="virtual_incr_seq");
	super.new(name);
endfunction
task virtual_incr_seq::body();
	super.body();
	incr_seqh=incr_seq::type_id::create("incr_seqrh");
	repeat(1)
		incr_seqh.start(ahb_seqrh);
endtask
	
class virtual_wrap4_seq extends virtual_sequence;
	`uvm_object_utils(virtual_wrap4_seq)

	wrap4_seq wrap4_seqh;
	extern function new(string name="virtual_wrap4_seq");
	extern task body();
endclass

function virtual_wrap4_seq::new(string name="virtual_wrap4_seq");
	super.new(name);
endfunction
task virtual_wrap4_seq::body();
	super.body();
	wrap4_seqh=wrap4_seq::type_id::create("wrap4_seqrh");
	repeat(1)
		wrap4_seqh.start(ahb_seqrh);
endtask
class virtual_single_seq extends virtual_sequence;
	`uvm_object_utils(virtual_single_seq)

	single_seq single_seqh;
	extern function new(string name="virtual_single_seq");
	extern task body();
endclass

function virtual_single_seq::new(string name="virtual_single_seq");
	super.new(name);
endfunction
task virtual_single_seq::body();
	super.body();
	single_seqh=single_seq::type_id::create("single_seqrh");
	repeat(1)
		single_seqh.start(ahb_seqrh);
endtask

	


















