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


