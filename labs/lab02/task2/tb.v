// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  localparam WIDTH = 8;
  localparam DEPTH = 4;
  localparam SEL_WIDTH = $clog2(DEPTH);

  // TODO: declare the inputs and outputs
  reg  [SEL_WIDTH-1:0] t_sel;
  wire [WIDTH-1:0]     t_dout;

  // TODO: instantiate DUT here
  lut #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH)
  ) DUT (
    .sel(t_sel),
    .dout(t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations
    integer i;
    for (i = 0; i < DEPTH; i = i + 1) begin
      t_sel = i;
      #5;
    end
    $finish;
  end

  initial
    $monitor($time, " SEL=%0d | DOUT=%0d (0x%0h)", t_sel, t_dout, t_dout); // change as required

endmodule
