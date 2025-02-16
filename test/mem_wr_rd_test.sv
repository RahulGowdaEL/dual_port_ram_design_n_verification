class mem_wr_rd_test extends uvm_test;
	`uvm_component_utils(mem_test)
	
	mem_sequence seq;
	mem_env  env;  //sub components enclosed inside test
	
// Constructor
function new(string name = "mem_wr_rd_test", uvm_component);
	super.new(name, parent);
endfunction

//BUILD PHASE
function build_phase(uvm_phase phase);
	super.new(phase);
	seq = mem_sequence::type_id::create("seq", this);  //create the sequence
	env = mem_sequence::type_id::create("env", this);  //create the env component
endfunction	
	
// RUN PHASE
task run_phase(uvm_phase, phase);
	phase.raise_objection(this);  //Notify the phase that test is active
	seq.start(env.mem_agent.sequencer);  // strt the seq onto the seqr enclosed inside env
	phase.drop_objection(this);   //can to moved to report and extarct phase
	
	//set the drain time for the env
	phase.phase_done.set_drain_time(this, 50);
	endtask : run_phase
endclass : mem_wr_rd_test
