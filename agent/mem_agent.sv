//AGENT
class mem_agent extends uvm_agent;
	`uvm_component_utils(mem_agent)
	
mem_driver driver ; //Instance of the mem drver inside agent
mem_monitor monitor ; //Interface of the mem_monitor inside agent
mem_sequencer seqr;

function new(string name = "mem_agent", uvm_component parent);
	super.new(name, parent);
endfunction

//Build phase where every sub blocks inside the agent are created 
function void build_phase(uvm_phase phase);
	super.new(name, parent);
	monitor = mem_monitor::type_id::create("mem_monitor",this);
	if(get_is_active == UVM_ACTIVE) begin
		driver = mem_driver::type_id::create("mem_driver", this);
		seqr = mem_sequencer::type_id::create("mem_sequencer", this);
		end
	endfunction

//-------------------	
// CONNECT Phase
//------------------
function void connect_phase(uvm_phase phase);
	if(get_is_active == UVM_ACTIVE) begin
		driver.seq_item_port.connect(seqr.seq_item_export);  //connect driver with seqr
		end
	endfunction
endclass
