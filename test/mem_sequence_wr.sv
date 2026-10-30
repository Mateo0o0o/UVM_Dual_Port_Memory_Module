`ifndef MEM_SEQUENCE_WR_SV
    `define MEM_SEQUENCE_WR_SV

    class mem_sequence_wr extends mem_sequence_base;
        
        `uvm_object_utils(mem_sequence_wr)
        
        local mem_addr addr;
        mem_sequence_reset reset_seq;

        function new(string name = "");
            super.new(name);
        endfunction //new()

        virtual task body();
            repeat(`TEST_NUM) begin
                item = mem_item::type_id::create("item");
                reset_seq = mem_sequence_reset::type_id::create("reset_seq");

                fork
                    begin
                       `uvm_do(reset_seq)
                    end

                    begin
                        item.rst_n = 1;
                        `uvm_do_with(item, {item.wr_en == 1;})
                        addr = item.addr;

                        `uvm_do_with(item, {
                            item.wr_en == 0; 
                            item.rd_en == 1; 
                            item.addr == local::addr;
                            })
                    end
                join

            end
        endtask

    endclass //mem_sequence extends uvm_sequencer

`endif