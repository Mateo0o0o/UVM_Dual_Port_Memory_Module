`ifndef MEM_ENV_SV
    `define MEM_ENV_SV

    import uvm_pkg::*;

    class mem_env extends uvm_env;
        
        mem_agent       agent;
        mem_scoreboard  scoreboard;

        `uvm_component_utils(mem_env)
        
        function new(string name = "", uvm_component parent);
            super.new(name, parent);
        endfunction //new()

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            
            agent       = mem_agent::type_id::create("agent", this);
            scoreboard  = mem_scoreboard::type_id::create("scoreboard", this);
        endfunction

        virtual function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);

            agent.monitor.analysis_port.connect(scoreboard.analysis_imp);            
        endfunction

    endclass //mem_env extends uvm_env

`endif