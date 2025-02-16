// SEQUENCE 
class mem_sequence extends uvm_sequence#(mem_seq_item);
  `uvm_object_utils(mem_sequence)  //Macro to register with uvm factory
  
//Constructor
function new(string name = "mem_sequence")
	super.new(name);
endfunction

`uvm_declare_p_sequncer(mem_sequencer)  // Declare a port to memory

//Virtual Task body
virtual task body();
	mem_seq_item req;  //create and handle of the transaction type
	repeat(5)  begin
		req = mem_seq_item::type_id::create("req");  //Create an object of txn to feed into DUT
		start_item(req);   //start onto the seqr
		assert(req.randomize(());  //Randomize the seq item
		finish_item(req);  //End of one successful txn
	end
	endtask
endclass
