//Interface

module memory_if(input clk, reset);
logic write_en;
logic read_en;
logic [31:0] addr;
logic [DATA_WIDTH -1:0] w_data;  //data to be written
logic [DATA_WIDTH -1:0] r_data;  //data retrived back

//---------------
//Driver clocking Block
//---------------

clocking driver_cb @(posedge clk);
default input #2 output #2;  //set the timing delays for the i/p and o/p
  output wr_en;
  output rd_en;
  output wr_data;
  output addr;
  input rd_data;
endclocking

//----------------
//Monitor Clocking Block
//----------------

clocking monitor_cb @(posedge clk);
default input #2 output #2; 
	input wr_en;
	input rd_en;
	input addr;
	input wr_data;
	output rd_data;
endclocking

//-----------------
//Driver MODPORTS
//-----------------

modport DRIVER(clocking driver_cb, input clk, reset);

//Monitor MODPORT
modport MONITOR(clocking monitor_cb, input clk, reset);
endinterface	
