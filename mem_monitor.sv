class mem_monitor extends uvm_monitor;
  virtual mem_if vif;
  uvm_analysis_port #(seq_item) item_collected_port;
  seq_item trans_collected;
  `uvm_component_utils(mem_monitor)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    trans_collected     = new();
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual mem_if)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", "virtual interface set edilmeli")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.MONITOR.clk);
      wait(vif.MONITOR.monitor_cb.wr_en || vif.MONITOR.monitor_cb.rd_en);
      trans_collected.addr  = vif.MONITOR.monitor_cb.addr;
      trans_collected.wr_en = vif.MONITOR.monitor_cb.wr_en;
      trans_collected.rd_en = vif.MONITOR.monitor_cb.rd_en;

      // yazma ise wdata'yi yakala
      if(vif.MONITOR.monitor_cb.wr_en)
        trans_collected.wdata = vif.MONITOR.monitor_cb.wdata;

      // okuma ise rdata otursun diye iki saat bekle
      if(vif.MONITOR.monitor_cb.rd_en) begin
        @(posedge vif.MONITOR.clk);
        @(posedge vif.MONITOR.clk);
        trans_collected.rdata = vif.MONITOR.monitor_cb.rdata;
      end

      item_collected_port.write(trans_collected);
    end
  endtask
endclass
