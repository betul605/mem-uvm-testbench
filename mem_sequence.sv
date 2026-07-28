class mem_sequence extends uvm_sequence #(seq_item);
  `uvm_object_utils(mem_sequence)

  function new(string name = "mem_sequence");
    super.new(name);
  endfunction

  task body();
    repeat(10) begin
      `uvm_do(req)
    end
  endtask
endclass
