`ifndef MEM_AGENT_CONFIG_SV
    `define MEM_AGENT_CONFIG_SV
    
    class mem_agent_config extends uvm_component;
        
        local mem_vif vif;

        `uvm_component_utils(mem_agent_config)

        function new(string name = "", uvm_component parent);
            super.new(name, parent);
        endfunction //new()

        virtual function mem_vif get_vif();
            `uvm_info("DEBUG", "Getting VIF", UVM_NONE)
            return vif;
        endfunction

        virtual function void set_vif(mem_vif value);
            if (vif == null) begin
                vif = value;
            end
            else begin
                `uvm_fatal("ALGORITHM ISSUE", "Trying to set the Virtual Interface more than once")
            end
        endfunction

        virtual function void start_of_simulation_phase(uvm_phase phase);
            
            super.start_of_simulation_phase(phase);
            
            if (get_vif() == null) begin
                `uvm_fatal("ALGORITHM ISSUE", "The Virtual Interface is not configured at \"Start of Simulation\" Phase")
            end
            else begin
                `uvm_info("MEM_CONFIG", "The Virtual Interface is CONFIGURED SUCCESSFULLY at \"Start of Simulation\" Phase", UVM_NONE)
            end

        endfunction

    endclass //mem_agent_config extends uvm_component

`endif