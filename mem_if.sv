`ifndef MEM_IF_SV
    `define MEM_IF_SV
    
    interface mem_if (input logic clk);
        logic               rst_n;
        logic               wr_en;
        logic               rd_en;
        logic [`AWIDTH-1:0] addr;
        logic [`DWIDTH-1:0] wdata;
        logic [`DWIDTH-1:0] rdata;

        modport dut (
            input   clk, rst_n, wr_en, rd_en, addr, wdata,
            output  rdata
        );

    endinterface //mem_if
    
`endif