`ifndef MEM_AGENT_SV
    `define MEM_AGENT_SV

    class mem_agent extends uvm_agent;
        
        mem_agent_config            agent_config;
        uvm_sequencer#(mem_item)    sequencer;
        mem_driver                  driver;
        mem_monitor                 monitor;
        mem_coverage                coverage;

        `uvm_component_utils(mem_agent)
        
        function new(string name="", uvm_component parent);
            super.new(name, parent);
        endfunction //new()

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            
            agent_config = mem_agent_config::type_id::create("agent_config", this);
            sequencer    = uvm_sequencer#(mem_item)::type_id::create("sequencer", this); 
            driver       = mem_driver::type_id::create("driver", this); 
            monitor      = mem_monitor::type_id::create("monitor", this); 
            coverage     = mem_coverage::type_id::create("coverage", this); 
        endfunction

        virtual function void connect_phase(uvm_phase phase);
            mem_vif vif;
            
            super.connect_phase(phase);

            if(!uvm_config_db#(mem_vif)::get(this, "", "vif", vif)) begin
                `uvm_fatal("NO_VIF", "Could not get the Virtual Interface from the Database")
            end
            else begin
                agent_config.set_vif(vif);
            end
            
            driver.agent_config = agent_config;
            driver.seq_item_port.connect(sequencer.seq_item_export);
            monitor.analysis_port.connect(coverage.analysis_export);
        endfunction

    endclass //mem_agent extends uvm_agent

`endif