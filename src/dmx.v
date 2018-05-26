module dmx(
    input wire dmxclk,
    output reg signal
);
    // this is just for me to figure out how many cycles I need for everything
    
    // break - can be any length of time
    // mark-after-break - 8us - 2 cycles
    // start bit - 4us - 1 cycle
    // start code - 32us - 8 cycles
    
    // channel data - 32us/channel * 512 channels = 16384us - 4096 cycles (8 per channel)
    
    // total (minus break) -  16428us - 4107 cycles
    // 30 dmx frames/sec --> 330000 us per frame - 82500 cycles
    // break = 330000 - 16428 = 313572 - 78393 cycles

    // so, general timeline:
    // break for 78393 cycles
    // MaB for 2 cycles (78395)
    // start bit for 1 cycle (78396)
    // start code for 8 cycles (78404)
    // channel data for 4096 cycles (82500)
    // go back to cycle 0

    reg [19:0] counter = 0;
    always @(posedge dmxclk) begin
        if (counter == 330000) begin 
            counter = 0;
        end else begin
            counter = counter + 1;
        end

        if (counter < 78393) begin
            assign signal = 1;
        end else if (counter >= 78393 && counter < 78395) begin
            assign signal = 0;
        end else if (counter >= 78395 && counter < 78396) begin
            assign signal = 1;
        end else if (counter >= 78396 && counter < 78404) begin
            assign signal = 0;
        end else if (counter >= 78404 && counter < 82500) begin
            assign signal = 1;
        end else begin
            assign signal = 0;
        end
    end
endmodule