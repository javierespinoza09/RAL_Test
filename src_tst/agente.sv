`include "sequence.sv"
`include "driver.sv"


class agent extends uvm_agent;
  `uvm_component_utils(agent)
  
  driver driver_ag;
  
  uvm_sequencer#(sequence_drv) sequence_ag;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    driver_ag = driver::type_id::create("driver_ag",this);
    sequence_ag =
    uvm_sequencer#(sequence_drv)::type_id::create("sequence_ag", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    driver_ag.seq_item_port.connect(sequence_ag.seq_item_export);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #5;
    `uvm_warning("","Para Javi, Ya funciona el agente 3 de 5")
    begin
      sequencer seq;
      seq = sequencer::type_id::create("seq");
      seq.start(sequence_ag);
    end
    phase.drop_objection(this);
  endtask
  
endclass