`ifndef MEM_TEST_BASE_SV
    `define MEM_TEST_BASE_SV

    class mem_test_base extends uvm_test;
        
        mem_env env;

        `uvm_component_utils(mem_test_base)
        
        function new(string name = "", uvm_component parent);
            super.new(name, parent);
        endfunction //new()

        virtual function void build_phase (uvm_phase phase);
            super.build_phase(phase);
            
            env = mem_env::type_id::create("env", this);
        endfunction
        
    endclass //mem_test extends uvm_test

`endif