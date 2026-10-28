`ifndef MEM_SCOREBOARD_SV
    `define MEM_SCOREBOARD_SV

    class mem_scoreboard extends uvm_scoreboard;
        
        `uvm_component_utils(mem_scoreboard)
        
        uvm_analysis_imp#(mem_item, mem_scoreboard) analysis_imp;

        function new(string name = "", uvm_component parent);
            super.new(name, parent);
            analysis_imp = new("analysis_imp", this);
        endfunction //new()


        // Reference Model

        mem_data expected_mem [`AWIDTH-1:0];          // Memory Array with size of mem_data and addresses of 2^AWIDTH
        bit      written_addr [`AWIDTH-1:0]; 

        virtual function void write(mem_item item);
            if (!item.rst_n) begin
                foreach(expected_mem[i]) expected_mem[i] = 0;
                foreach(written_addr[i]) written_addr[i] = 0;
            end
            else if (item.wr_en) begin
                expected_mem[item.addr] = item.wdata;
                written_addr[item.addr] = 1;
            end
            else if (item.rd_en) begin
                if(!written_addr[item.addr]) begin
                    `uvm_info(get_type_name(), $sformatf("addr: %0x read before write, skipping check", item.addr), UVM_LOW);
                end
                else if (item.rdata != expected_mem[item.addr]) begin
                    `uvm_error(get_type_name(), $sformatf("Mismatch at addr %0x : Expected= %0x, Actual= %0x", 
                                                            item.addr, expected_mem[item.addr], item.rdata))
                end 
                else begin
                    `uvm_info(get_type_name(), $sformatf("addr=%0x matched: Data=%0x", item.addr, item.wdata), UVM_HIGH)
                end
            end
            
        endfunction

    endclass //mem_scoreboard extends uvm_scoreboard#(mem_item)

`endif