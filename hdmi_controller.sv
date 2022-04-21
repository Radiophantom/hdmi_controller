import hdmi_controller_pkg::*;

module hdmi_controller(
  input         rst_i,
  input         clk_i,

  input         en_i,

  output        vsync_o,
  output        hsync_o,
  output        de_o,

  output [23:0] data_o
);

//******************************************************************************
// Local parameters
//******************************************************************************

localparam H_SYNC_CNT_W = $clog2( H_TOTAL );
localparam V_SYNC_CNT_W = $clog2( V_TOTAL );

//******************************************************************************
// Variables declaration
//******************************************************************************

logic [7:0]               r_pix_value_cnt;
logic [7:0]               g_pix_value_cnt;
logic [7:0]               b_pix_value_cnt;

logic                     vsync;
logic                     vsync_start;
logic                     vsync_end;
logic                     hsync;
logic                     hsync_start_stb;
logic                     hsync_end_stb;
logic                     de;
logic                     de_enable;

logic [H_SYNC_CNT_W-1:0]  hsync_cnt;
logic [V_SYNC_CNT_W-1:0]  vsync_cnt;

logic [23:0]              data;

//******************************************************************************
// Frame pixel value control
//******************************************************************************

always_ff @( posedge clk_i, posedge rst_i )
  if( rst_i )
    begin
      r_pix_value_cnt <= '0;
      g_pix_value_cnt <= '0;
      b_pix_value_cnt <= '0;
    end
  else
    if( en_i )
      begin
        if( vsync_end && hsync_end_stb )
          begin
            r_pix_value_cnt <= { r_pix_value_cnt[6:0], r_pix_value_cnt[5]^r_pix_value_cnt[3] };
            g_pix_value_cnt <= { g_pix_value_cnt[6:0], g_pix_value_cnt[5]^g_pix_value_cnt[3] };
            b_pix_value_cnt <= { b_pix_value_cnt[6:0], b_pix_value_cnt[5]^b_pix_value_cnt[3] };
          end
      end
    else
      begin
        r_pix_value_cnt <= 8'hAA;
        g_pix_value_cnt <= 8'hFF;
        b_pix_value_cnt <= 8'h55;
      end


//******************************************************************************
// VSYNC generation
//******************************************************************************

always_ff @( posedge clk_i, posedge rst_i )
  if( rst_i )
    vsync_cnt <= '0;
  else
    if( en_i && hsync_end_stb )
      if( vsync_cnt == V_TOTAL-1 )
        vsync_cnt <= '0;
      else
        vsync_cnt <= vsync_cnt + 1'b1;

always_ff @( posedge clk_i, posedge rst_i )
  if( rst_i )
    vsync <= 1'b0;
  else
    if( en_i )
      vsync <= ( vsync_cnt <= V_SYNC-1 );
    else
      vsync <= 1'b0;

assign vsync_start = vsync_cnt == 0;
assign vsync_end   = vsync_cnt == V_TOTAL-1;

//******************************************************************************
// HSYNC generation
//******************************************************************************

always_ff @( posedge clk_i, posedge rst_i )
  if( rst_i )
    hsync_cnt <= '0;
  else
    if( en_i )
      if( hsync_cnt == H_TOTAL-1 )
        hsync_cnt <= '0;
      else
        hsync_cnt <= hsync_cnt + 1'b1;

always_ff @( posedge clk_i, posedge rst_i )
  if( rst_i )
    hsync <= 1'b0;
  else
    if( en_i )
      hsync <= ( hsync_cnt <= H_SYNC-1 );
    else
      hsync <= 1'b0;

assign hsync_start_stb = hsync_cnt == 0;
assign hsync_end_stb   = hsync_cnt == H_TOTAL-1;

//******************************************************************************
// DE generation
//******************************************************************************

assign de_enable = ( vsync_cnt > V_START-1 && vsync_cnt < V_END-1 ) &&
                   ( hsync_cnt > H_START-1 && hsync_cnt < H_END-1 );

always_ff @( posedge clk_i, posedge rst_i )
  if( rst_i )
    de <= 1'b0;
  else
    if( en_i )
      de <= de_enable;
    else
      de <= 1'b0;

//******************************************************************************
// Pixel values control
//******************************************************************************

always_ff @( posedge clk_i )
  if( de_enable )
    data <= { r_pix_value_cnt, g_pix_value_cnt, b_pix_value_cnt };

//******************************************************************************
// Assign outputs
//******************************************************************************

assign vsync_o = vsync;
assign hsync_o = hsync;
assign de_o    = de;

assign data_o  = data;

endmodule

/*

hdmi_controller hdmi_controller (
  .rst_i   ( ),
  .clk_i   ( ),

  .en_i    ( ),

  .vsync_o ( ),
  .hsync_o ( ),
  .de_o    ( ),

  .data_o  ( )
);

*/
