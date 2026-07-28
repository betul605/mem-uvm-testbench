class mem_agent extends uvm_agent;
  mem_driver         driver;
  mem_monitor        monitor;
  mem_sequencer_item sequencer;
  `uvm_component_utils(mem_agent)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver    = mem_driver::type_id::create("driver", this);
    monitor   = mem_monitor::type_id::create("monitor", this);
    sequencer = mem_sequencer_item::type_id::create("sequencer", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
endclass
