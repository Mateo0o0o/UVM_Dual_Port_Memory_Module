`ifndef MEM_SEQUENCE_WR_SV
    `define MEM_SEQUENCE_WR_SV

    class mem_sequence_wr extends mem_sequence_base;
        
        `uvm_object_utils(mem_sequence_wr)
        
        local mem_addr addr;

        function new(string name = "");
            super.new(name);
        endfunction //new()

        virtual task body();
            repeat(`TEST_NUM) begin
                item = mem_item::type_id::create("item");
                
                `uvm_do_with(item, {item.wr_en == 1;})
                addr = item.addr;
                // `uvm_info(get_type_name(), $sformatf("addr=%0x, item.addr=%0x", addr, item.addr) , UVM_NONE)

                `uvm_do_with(item, {
                    item.wr_en == 0; 
                    item.rd_en == 1; 
                    item.addr == local::addr;
                    })

                `uvm_info(get_type_name(), "Driving", UVM_NONE)
            end
        endtask

    endclass //mem_sequence extends uvm_sequencer

`endif