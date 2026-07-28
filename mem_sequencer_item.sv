class mem_sequencer_item extends uvm_sequencer #(seq_item);
  `uvm_component_utils(mem_sequencer_item)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass
