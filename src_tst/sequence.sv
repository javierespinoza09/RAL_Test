//Para Javi <3
class sequence_drv extends uvm_sequence_item;
  `uvm_object_utils(sequence_drv)
  
  rand bit algo;
  
  function new (string name = "");
    super.new(name);
  endfunction
  
endclass


class sequencer extends uvm_sequence #(sequence_drv);
  `uvm_object_utils(sequencer)
  
  function new (string name = "");
    super.new(name);
  endfunction
  
  task body;
      req = sequence_drv::type_id::create("req");
      start_item(req);

      if (!req.randomize()) begin
        `uvm_error("MY_SEQUENCE", "Randomize failed.");
      end

      finish_item(req);
  endtask: body

endclass