`ifndef MEM_DRIVER_SV
    `define MEM_DRIVER_SV

    class mem_driver extends uvm_driver#(mem_item);
        
        mem_agent_config agent_config;

        `uvm_component_utils(mem_driver)

        function new(string name = "", uvm_component parent);
            super.new(name, parent);
        endfunction //new()

        virtual task run_phase(uvm_phase phase); 

            drive_items();

        endtask

        virtual task drive_items();
            mem_vif vif = agent_config.get_vif();

            // Initialize Signals
            vif.addr    <= 0;
            vif.wdata   <= 0;
            vif.wr_en   <= 0;
            vif.rd_en   <= 0;

            forever begin
                mem_item item;
                seq_item_port.get_next_item(item);
                drive_sigs(vif, item);
                seq_item_port.item_done(item);
            end

        endtask

        virtual task drive_sigs(mem_vif vif, mem_item item);

            `uvm_info("DEBUG", item.convert2string(), UVM_NONE)

            @(negedge vif.clk);
            vif.addr    <= item.addr;
            vif.wdata   <= item.wdata;
            vif.wr_en   <= item.wr_en;
            vif.rd_en   <= item.rd_en;
            @(negedge vif.clk);

            vif.wr_en   <= 0;
            vif.rd_en   <= 0;

            if(item.rd_en) begin
                @(negedge vif.clk);
                item.rdata = vif.rdata;
            end

        endtask
    endclass //mem_driver extends uvm_driver#(mem_item)

`endif