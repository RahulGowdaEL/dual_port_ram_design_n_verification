//ENVIRONMENT

class mem_env extends uvm_env;
	`uvm_component_utils(mem_env);
	
mem_agent agent;  //instance of the agent and scoreboard enclosed inside the env should be defined
mem_scoreboard scoreboard;

//Constructor
function new(string name = "mem_en", uvm_component parent);
	super.new(name, parent);
endfunction

//BUILD phase
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	agent = mem_agent::type_id::create("agent", this);
	scoreboard = mem_scoreboard::type_id::create("scoreboard", this);
endfunction 

function void connect_phase(uvm_phase phase);
	agent.monitor.item_collect_port.connect(scoreboard.item_collect_export);
	endfunction
endclass : env
