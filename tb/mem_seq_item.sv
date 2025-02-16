//Memory Transaction
class mem_seq_item extends uvm_sequence_item
`uvm_object_utils(mem_seq_item)

//------------
// Define Random DATA_WIDTH
//------------
rand bit [7:0] wdata;  //data which we needed to write
rand bit [1:0] addr;  //2-bit addr to locate the data 
rand bit wr_en;  //one bit cntrl for wrtiing
rand bit rd_en;  //one bit control signal for reading
rand bit[7:0] rdata;   //Reading 8-bit data from the memory

//Constructor
function new(string name = "mem_seq_item");
	super.new(name);  //call the base class constructor
endfunction

//Constraint for the dut i/p
constraint wr_rd_c { wr_en != rd_en ;}; //Ensure that symultaneous rd and wr should not happen
endclass
