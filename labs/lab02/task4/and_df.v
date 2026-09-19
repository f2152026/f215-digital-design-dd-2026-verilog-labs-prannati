module and_df #(
  parameter DELAY = 5
) (
  input  a,
  input  b,
  output y
);

  assign #DELAY y = a & b;

endmodule