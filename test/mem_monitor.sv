`ifndef MEM_MONITOR_SV
    `define MEM_MONITOR_SV

    class mem_monitor extends uvm_monitor;
        
        mem_vif vif;

        uvm_analysis_port#(mem_item) analysis_port;

        `uvm_component_utils(mem_monitor)
        
        function new(string name = "", uvm_component parent);
            super.new(name, parent);
        endfunction //new()

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            
            analysis_port = new("analysis_port", this);

            if(!uvm_config_db#(mem_vif)::get(this, "", "vif", vif)) begin
                `uvm_error(get_type_name(), "Could not get Virtual Interface from database")
            end
            
        endfunction

        virtual task run_phase(uvm_phase phase);
            mem_item item;

            forever begin

                fork
                    begin
                        item = mem_item::type_id::create("item", this);
                        item.rst_n  = vif.rst_n;  
                        analysis_port.write(item);
                    end

                    begin    
                        @(posedge vif.clk);
                        if(vif.wr_en) begin
                            item = mem_item::type_id::create("item", this);
                            item.rst_n  = 1;  
                            item.wr_en  = 1;  
                            item.addr   = vif.addr;
                            item.wdata  = vif.wdata;
                            analysis_port.write(item);
                            // `uvm_info("DEBUG", "Monitoring Write", UVM_NONE)
                        end
                        else if (vif.rd_en) begin
                            item = mem_item::type_id::create("item", this);
                            item.rst_n  = 1;  
                            item.rd_en  = 1;  
                            item.addr   = vif.addr;

                            @(posedge vif.clk);
                            item.rdata  = vif.rdata;
                            analysis_port.write(item);
                            // `uvm_info("DEBUG", "Monitoring Read", UVM_NONE)
                        end
                    end
                join

            end

        endtask

    endclass //mem_monitor extends uvm_monitor

`endif