module top(
    input wire clk,
    output wire power_led,

    input wire rx,
    output wire tx,

    output wire dmx1,
    output wire dmx1n,
    output wire dmx1s
);
    wire dmxclk;

    assign power_led = 1;
    assign dmx1s = 1;
    assign dmx1n = ~dmx1;

    // the result clock here has an extra 5hz since 250kHz gave me 4.2us, but 250005hz gave me 4us. guess the input clock isn't exactly 12MHz?
    fdiv #(.clock_hz(12000000), .hz(250005)) clk0(.clock(clk), .reset(1'b0), .out_clock(dmxclk));
    dmx dmx0(.dmxclk(~dmxclk), .signal(dmx1));
endmodule