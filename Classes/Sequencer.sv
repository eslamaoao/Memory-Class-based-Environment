class Sequencer;
  Transaction tr;
  mailbox seq_mailbox;
  

  function new();
    seq_mailbox = new(1);
  endfunction

  task generate_values();
    
    repeat(200) 
     begin
      
      tr = new();
      if(!tr.randomize())
        begin
         	$error("%0t = ns Sequencer: Randomization failed for transaction!", $time);
        	$finish; // Terminate the simulation
        end
      
      seq_mailbox.put(tr); // Send the transaction

    end
  endtask
  
endclass

