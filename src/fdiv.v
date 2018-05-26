// From https://blog.ijat.my/verilog-frequency-divider since I was too lazy to make my own

module fdiv(
  input clock, reset,
  output reg out_clock
  );
  
  reg [31:0] count;
  wire [31:0] hertz;
  
  parameter clock_hz = 32'd50000000;
  parameter hz = 32'd1;
  
  initial out_clock = 32'b0;
  initial count = 32'b0;
  
  assign hertz = clock_hz / (hz * 2);
  
  always @(posedge clock, posedge reset)
  begin
    if (reset == 1'b1) 
        begin
        count <= 32'b0;
        out_clock <= 32'b0;
      end
    else if (count == hertz) 
    begin
        count <= 32'b0;
        out_clock = ~out_clock;
    end
    else begin
        count <= count + 1;
        out_clock <= out_clock;
      end
  end  
  
endmodule