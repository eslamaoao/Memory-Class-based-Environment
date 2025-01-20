class Env;
  
  Sequencer sequencer;
  Driver driver;
  Monitor monitor;
  Scoreboard scoreboard;
  Subscriber subscriber;
  
  function new();
    sequencer  = new();
    driver     = new();
    monitor    = new();
    scoreboard = new();
    subscriber = new();
  endfunction

  
  
  task run(virtual intf intf1);
    
    sequencer.seq_mailbox 	 = driver.driv_mailbox;
  	scoreboard.score_mailbox = monitor.mon_mailbox_for_scoreboard;
    subscriber.subs_mailbox  = monitor.mon_mailbox_for_subscriber;
    
    fork
      sequencer.generate_values(); // Generate transactions
      driver.drive(intf1);  // Drive transactions to DUT
      monitor.mon(intf1);
      scoreboard.check(intf1);
      subscriber.collect();
    join_any
    
  endtask
  
endclass

