

class Transaction;

rand logic rst,en,w_r;
randc logic [3:0] address;
randc logic [31:0] data_in;

logic [31:0]data_out;
logic valid_out;
  
  constraint constr1 {en dist {1:= 100,0:=10};}
  constraint constr2 {rst dist {1:= 100,0:=10};}
 
	//constraint constr2 {rst inside {1};}
  constraint constr3 {data_in inside {[1:100]};}
  
endclass 






