`ifndef MEM_SEQUENCE_BASE_SV
    `define MEM_SEQUENCE_BASE_SV
        class mem_sequence_base extends uvm_sequence#(mem_item);
            
            mem_item        item;
            int unsigned    iterations = 1;

            `uvm_object_utils(mem_sequence_base)
            
            function new(string name = "");
                super.new(name);        
            endfunction //new()

            virtual function void set_iterations(int unsigned iter);
                iterations = iter;
            endfunction

        endclass //mem_sequence_base extends uvm_sequence_item
`endif