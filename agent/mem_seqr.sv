//SEQUENCER

class mem_sequencer extends uvm_sequencer#(mem_seq_item);
	`uvm_component_utils(mem_sequencer)
	
function new(string name = "mem_sequencer", uvm_component parent);	
    super.new(name,parent);  //call be class constructor with name and the parent comp name
endfunction
endclass
