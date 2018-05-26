`default_nettype none
`timescale 1ns/1ns
`define DUMPSTR(x) `"x.vcd`"

module dmx_tb();
    parameter duration = 175000;
    reg clk = 0;
    always #1 clk = ~clk;
    wire dmx_signal;
    dmx d0(
        .dmxclk(clk),
        .signal(dmx_signal)
    );

    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, dmx_tb);
        #(duration) $display("END of simulation");
        $finish;
    end
endmodule
