`include "interface.sv"

`timescale 1ns/1ns

module Mem_tb() ;

import pack::*;

parameter clock_period = 10;

intf intf1();

 

Mem DUT(.mod1(intf1));

Env env;

initial 
 begin
     $dumpfile("dump.vcd"); // to get waveform
    $dumpvars;
 intf1.CLK=0;
 #1;
  intf1.RST=0;
  #10
  
	env= new();
	env.run(intf1);
	

	

 //#100
 
$stop;

 end
 
always #(clock_period / 2) intf1.CLK = ~intf1.CLK;



endmodule


/*driver1 = new ();
monitor1 = new ();

driver1.clk = 1;
driver1.rst = 0;
driver1.en = 1;
driver1.w_r = 1; // Write
driver1.address = 4'h3;
driver1.data_in = 32'd120;

driver1.driv(intf1);
#10;
driver1.rst = 1;
driver1.driv(intf1);
#30
driver1.w_r = 0; // Write
#30
$display($time ,"ns data_out = %0d",monitor1.data_out);
	
$display($time ,"ns valid_out = %0d",monitor1.valid_out);
$display($time ,"ns valid_out = %0d",DUT.Valid_Out);

 driver1.driv(intf1);
 
 #30
 $display($time ,"ns data_out = %0d",monitor1.data_out);
	
$display($time ,"ns valid_out = %0d",monitor1.valid_out);
 monitor1.mon(intf1);
 $display(  $time ,"ns data_out = %0d",monitor1.data_out);
	
$display( $time ,"ns valid_out = %0d",monitor1.valid_out);
 #200;*/