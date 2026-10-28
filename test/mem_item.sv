`ifndef MEM_ITEM_SV
    `define MEM_ITEM_SV

    class mem_item extends uvm_sequence_item;
        
             bit        rst_n;
        rand mem_addr   addr;
        rand mem_data   wdata;
             mem_data   rdata;
        rand bit        wr_en;
        rand bit        rd_en;

        // `uvm_object_utils(mem_item)
        `uvm_object_utils_begin(mem_item)
            `uvm_field_int(addr, UVM_ALL_ON)
            `uvm_field_int(wdata, UVM_ALL_ON)
            `uvm_field_int(rdata, UVM_ALL_ON)
            `uvm_field_int(wr_en, UVM_ALL_ON)
            `uvm_field_int(rd_en, UVM_ALL_ON)
        `uvm_object_utils_end
        
        function new(string name="");
            super.new(name);
        endfunction //new()

        virtual function string convert2string();
            string result = $sformatf("wr_en: %1b, rd_en: %1b, addr: %0x", wr_en, rd_en, addr);

            if(wr_en & !rd_en) begin
                result = $sformatf("%0s, data: %0x", result, wdata);
            end

            return result;
        endfunction

    endclass //mem_item extends uvm_sequence_item

`endif