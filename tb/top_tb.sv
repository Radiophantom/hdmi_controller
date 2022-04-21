`timescale 1 ns / 1 ns

module top_tb;

bit rst;
bit clk;

always #5 clk = ~clk;

logic        en;
logic        vsync, hsync, de;
logic [23:0] data;

hdmi_controller DUT (
  .rst_i   ( rst   ),
  .clk_i   ( clk   ),

  .en_i    ( en    ),

  .vsync_o ( vsync ),
  .hsync_o ( hsync ),
  .de_o    ( de    ),

  .data_o  ( data  )
);

initial
  begin
    rst <= 1'b1;
    @( posedge clk );
    rst <= 1'b0;

    en <= 1'b1;

    repeat( 2200*1125 + 100 )
      @( posedge clk );

    $stop();
  end

endmodule
