module tb;

  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;
  wire [3:0] t_result;

  reg  [3:0] exp_result;
  integer errors = 0;
  integer i, j;

  alu DUT (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    t_a = 4'd7;
    t_b = 4'd3;
    t_op = 1'b0; 
    #5;
    exp_result = 4'd10;
    if (t_result !== exp_result) begin
      $display("ERROR [Add]: A=%d B=%d OP=%b | Got %d, Expected %d", t_a, t_b, t_op, t_result, exp_result);
      errors = errors + 1;
    end
    t_op = 1'b1;
    #5;
    exp_result = 4'd4;
    if (t_result !== exp_result) begin
      $display("ERROR [Sub OP Toggle]: A=%d B=%d OP=%b | Got %d, Expected %d", t_a, t_b, t_op, t_result, exp_result);
      errors = errors + 1;
    end

    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        t_a = i[3:0];
        t_b = j[3:0];

        t_op = 1'b0;
        #5;
        exp_result = t_a + t_b;
        if (t_result !== exp_result) begin
          $display("ERROR [ADD Sweep]: A=%d B=%d | Got %d, Expected %d", t_a, t_b, t_result, exp_result);
          errors = errors + 1;
        end

        t_op = 1'b1;
        #5;
        exp_result = t_a - t_b;
        if (t_result !== exp_result) begin
          $display("ERROR [SUB Sweep]: A=%d B=%d | Got %d, Expected %d", t_a, t_b, t_result, exp_result);
          errors = errors + 1;
        end
      end
    end

    if (errors == 0) begin
      $display("SUCCESS: All ALU tests passed!");
    end else begin
      $display("FAILURE: Found %0d error(s) during ALU execution.", errors);
    end

    $finish;
  end

endmodule