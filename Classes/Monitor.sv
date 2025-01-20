
class Monitor;

  mailbox mon_mailbox_for_scoreboard;
  mailbox mon_mailbox_for_subscriber;
  Transaction mon_tr;
  
  function new();
    mon_mailbox_for_scoreboard = new(1); 
    mon_mailbox_for_subscriber = new(1); 
  endfunction


  // Task to monitor DUT outputs
  task mon(virtual intf intf1);
    forever 
     begin
      @(intf1.cb_monitor); 
      mon_tr = new();

      // Capture DUT output signals
       
      mon_tr.data_out  = intf1.cb_monitor.Data_Out;  
      mon_tr.valid_out = intf1.cb_monitor.Valid_Out;         
      mon_tr.address   = intf1.cb_monitor.Address;
      mon_tr.data_in   = intf1.cb_monitor.Data_In;
      mon_tr.w_r   	   = intf1.cb_monitor.W_R;
      mon_tr.en  	   = intf1.cb_monitor.EN;
	  mon_tr.rst  	   = intf1.cb_monitor.RST;
      
       
      mon_mailbox_for_scoreboard.put(mon_tr);
      mon_mailbox_for_subscriber.put(mon_tr);


    end
  endtask

endclass


