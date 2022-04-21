package hdmi_controller_pkg;

//******************************************************************************
// Setting of horizontal scan parameters 1980*1080 60HZ
//******************************************************************************

parameter H_TOTAL   = 2200;
parameter H_SYNC    = 44;
parameter H_BACK    = 148;
parameter H_ACTIVE  = 1920;
parameter H_FRONT   = 88;
parameter H_START   = H_BACK  + H_SYNC;
parameter H_END     = H_START + H_ACTIVE;

//******************************************************************************
// Setting of vertical scan parameters 1920*1080 60HZ
//******************************************************************************

parameter V_TOTAL   = 1125;
parameter V_SYNC    = 5;
parameter V_BACK    = 37;
parameter V_ACTIVE  = 1080;
parameter V_FRONT   = 3;
parameter V_START   = V_BACK  + V_SYNC;
parameter V_END     = V_START + V_ACTIVE;

endpackage
