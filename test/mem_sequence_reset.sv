`ifndef MEM_SEQUENCE_RESET_SV
    `define MEM_SEQUENCE_RESET_SV

    class mem_sequence_reset extends mem_sequence_base;

        mem_item item;

        `uvm_object_utils(mem_sequence_reset)

        function new(string name = "");
            super.new(name);
        endfunction //new()

        virtual task body();

            if ($urandom_range(20) == 0) begin
                item = mem_item::type_id::create("item");
                start_item(item);
                item.rst_n = 0;
                finish_item(item);
                `uvm_info(get_type_name(), "RESETTING", UVM_NONE)
            end

        endtask

    endclass //mem_sequence_reset extends uvm_sequence#(mem_item item)



`endif