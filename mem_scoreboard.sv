class mem_scoreboard extends uvm_scoreboard;
  bit [7:0] sc_mem [4];
  uvm_analysis_imp #(seq_item, mem_scoreboard) item_collected_export;
  `uvm_component_utils(mem_scoreboard)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_export = new("item_collected_export", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    foreach(sc_mem[i]) sc_mem[i] = 8'hFF;   // DUT reset'te FF yapiyordu
  endfunction

  function void write(seq_item pkt);
    if (pkt.wr_en) begin
      sc_mem[pkt.addr] = pkt.wdata;
      `uvm_info(get_type_name(),
        $sformatf("WRITE -> addr=%0d, wdata=0x%0h", pkt.addr, pkt.wdata), UVM_LOW)
    end
    else if (pkt.rd_en) begin
      if (sc_mem[pkt.addr] == pkt.rdata)
        `uvm_info(get_type_name(),
          $sformatf("MATCH -> addr=%0d, exp=0x%0h, dut=0x%0h",
            pkt.addr, sc_mem[pkt.addr], pkt.rdata), UVM_LOW)
      else
        `uvm_error(get_type_name(),
          $sformatf("MISMATCH -> addr=%0d, exp=0x%0h, dut=0x%0h",
            pkt.addr, sc_mem[pkt.addr], pkt.rdata))
    end
  endfunction
endclass
