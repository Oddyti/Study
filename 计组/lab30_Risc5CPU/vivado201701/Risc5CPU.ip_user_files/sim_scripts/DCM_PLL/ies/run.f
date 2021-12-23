-makelib ies/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2017.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies/xpm \
  "D:/Xilinx/Vivado/2017.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../Risc5CPU.srcs/sources_1/ip/DCM_PLL/DCM_PLL_clk_wiz.v" \
  "../../../../Risc5CPU.srcs/sources_1/ip/DCM_PLL/DCM_PLL.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

