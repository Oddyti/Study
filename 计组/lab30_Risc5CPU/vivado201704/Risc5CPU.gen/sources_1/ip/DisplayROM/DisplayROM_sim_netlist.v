// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1.1 (win64) Build 3286242 Wed Jul 28 13:10:47 MDT 2021
// Date        : Thu Dec 23 14:42:59 2021
// Host        : Oddyti-Kevin running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Modelsim/lab30_Risc5CPU/vivado201704/Risc5CPU.gen/sources_1/ip/DisplayROM/DisplayROM_sim_netlist.v
// Design      : DisplayROM
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "DisplayROM,dist_mem_gen_v8_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2021.1.1" *) 
(* NotValidForBitStream *)
module DisplayROM
   (a,
    clk,
    qspo);
  input [7:0]a;
  input clk;
  output [7:0]qspo;

  wire [7:0]a;
  wire clk;
  wire [7:0]qspo;
  wire [7:0]NLW_U0_dpo_UNCONNECTED;
  wire [7:0]NLW_U0_qdpo_UNCONNECTED;
  wire [7:0]NLW_U0_spo_UNCONNECTED;

  (* C_FAMILY = "artix7" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "0" *) 
  (* C_HAS_I_CE = "0" *) 
  (* C_HAS_QDPO = "0" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_WE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_PIPELINE_STAGES = "0" *) 
  (* C_QCE_JOINED = "0" *) 
  (* C_QUALIFY_WE = "0" *) 
  (* C_REG_DPRA_INPUT = "0" *) 
  (* c_addr_width = "8" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "256" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_clk = "1" *) 
  (* c_has_qspo = "1" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_has_qspo_rst = "0" *) 
  (* c_has_qspo_srst = "0" *) 
  (* c_has_spo = "0" *) 
  (* c_mem_init_file = "DisplayROM.mif" *) 
  (* c_parser_type = "1" *) 
  (* c_read_mif = "1" *) 
  (* c_reg_a_d_inputs = "0" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "8" *) 
  (* is_du_within_envelope = "true" *) 
  DisplayROM_dist_mem_gen_v8_0_13 U0
       (.a(a),
        .clk(clk),
        .d({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dpo(NLW_U0_dpo_UNCONNECTED[7:0]),
        .dpra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[7:0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(qspo),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(NLW_U0_spo_UNCONNECTED[7:0]),
        .we(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2021.1.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
ayFAGEOqMzP5QAMxeaS2Qk5SuL6sQ84yrHS4TcsJ4IwJfDlMtzl1NkJ9SBevFKCnP66utQlJWw2Q
FQM1z8ln6NWRdox36WE72dN85/JfxG8vSRJlMkP/WX6hEptOsJuvUXUxGYnw51QQZRhi8o4BiGrn
b1uC1HOjnQ4t2Is8v3A=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
JRt3f4XCd0IgGDixT8B/N3QXiFxFdwwmFYViCvm6Y/xAsOH81mGMQ1pzPXYmMOxi/iGoAWJq3tBy
cG3iH2C1Sk+dWhrzOex9EcaZDIEzlv/XMlBK7FMSr0yCbd8AvlL/09LW7jYC6vQx/hP+OUfRwqv1
W4OAeX6ws+z6yxekzCgbqDHbYvAWb1IcjSIL4dg9E256LVXv62K5AfVYmQ3cGtIBxNFSQ/krlDtk
pDeAJ0BDwbeQq1bX1PZOqmO/Qxd3vYzl8GEYbKdFMfNc+v6/itz32pJoWJmrUy9GIEyoY8X74WtO
xtQZ1SQMhjaW76ie9uHC8VDK7UFiASD35Oza9Q==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
AhescPf4B1Fqi/0hk7dnuUeskChvxc/q8St+XXlvRmuxJjMae1fFPSR2JBUugPH7gAPD3j/279Xq
0YB48eR89Xhd5gxyiLaiawhtbpnpTyOcOa+wYJKjaWKIIsHXreFAGdxyOHSniLgGKdnuDLvUcB8t
xOGo6IRt55HJzUeV0Ms=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TRGl9lKkUY/ybilmnZg3s1oAI+BR5N2n1Nft2PtZifVBIxs+xfcHl+d5a2Iq6VVme8ltp86vQpDP
rn6ukHFN6rztIZG7l33CrwaFLhFit7kEYvWH144eEUSWCsyNrJh93jaoKOfZtijYZVbX/2Cohx8U
nSsLayx1mS5mHIHeinGrbts7oBTY3qWmMc283irq850qbwr9aW4SGRcN9ae9QInMsVxgd3uNkJyi
DgLyyDkkHqwIlWJUA6o6eu+5Nz/ZNYwOQHMBgrGuvome+hJhexgMTtsHCBobJW8DMdIjLL2vODIJ
XWFiq3mgp9MaE01Dtb9ePOrhQYi6sbKJwsu+6g==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PhYumu7GubhzdedZ/P3KHfaFo0+sBDSOc+IjJvIfj6As0WX0h3Ootxl73AupzuAriximPE/aD0bW
KOBrjeNaQMHijBXY5OcqBv7pxYcuKDPNuKdFfUr3zeK0r0mUoQLoYZEe/bTQOmkxxyualOD4ABSU
6BzQISun+PJkvuj6rL8SyQcvQmDg19wOvaFD5cCSX85anxM7+KUmRZt7IAjvBzMEZ5XUtG1dUVeG
b8Q8gX3GCZS1q8msYFFQATh1AA7BZRRxQL/rIlvJIyyhOlisLHInQm4eIlWG4W/uJ876fd9BgTiF
iS6WduIxkuyxI9P1C4FdfXxEQJYvhzdsvC/K2w==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_01", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ekpohmx8et4GG+CUHQKFVrTpw3ojt5HaolU+pXr/FfcSfAvmMKAAeRjSjufHOZ56Ut39QflnuONR
mxfA5xx8AXgNUtI4N7bdG7zGLk3vDR+IohGtCh2zfHlnNBBEDD/2ERE7GjZIw8RdiPIhus903QeL
GTZQnw8Xvxgn/0moDM8Zsk5PvW/xTcvYI301lv4sL7Fm6LQkpzSqAE72m7UpmlRRxnZ4bmJH2n1v
nc4C1UNkwtBM9zj0cDpPpJB6eX983w0b/TQPuPqL/JhcZBwhA49KCLcyoPAQe+WHBibbA3aTmR3J
1rqAmodNDKAsX48DJ9jiJT42if/eRDdkuy5DHQ==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mPyUS3RhNgQqF6sD14bYx7OZQ7MBgvlNqIRi8NXMCFd3Khlowl7snQTnOZl7OAMwAtpTn0jrN+Vl
moYK8mZaVkffxq0O/2f+5cSG/nDAS5mLRn4GuziZavVpcL8P7r9eBihaHUxUoetzgBFqjmUO7E58
gygHGeFF4JrprIJmosg045EMURhUz7vQ0t1BuU01oRD/8qULhRsLQPpqm7HKzttkqiinIEMzLHU9
z3XtUz3/w9TNxBQnv4kaDnVFzi8e51TLOE5I4OFYDqtr/oMsGqdLsycVZ5wR0GV9ZQw0DbQRTPNp
BPjjwCKpDwNnIoz19nMNpMaMf8Sfy8R8Buk8tQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
anGyKV3SdDjswIzRn9XCAH1ayCiLUhtaLKYIWG3dwr7TEN1W+L8MFlQngOz7IEa47hHznm+uVB5o
z0dMy7qFCb3w0s8uGdDFvnJmwKpHDugp3kdvPEG+xWQKeOrlnxbrC9G7gFyjCuKgv66vAF5pNBCT
SHwEAKhVYIl0b+lomXUjD+dyVKGtWmjxSVTWh8cOcMT17UoqP0KzSe/PD49Ow7Iid6LlCYlKHWf8
PQ8x6UIu3yGL0HX/Pqv8+oFr8+3w4c5cLO43wYXjMjMvp4YNShihyvAVFdCx6cUTxQTOmVJGxN1H
VwxZJv7PIsluyrVFR7IYsHfpG5VM+iQRBII6pwYvajc8eBZPqqIokrxvDtGPi05XJYEzw4mZqAeY
Wc8YLzdbg4c3WxQHqcj2eI7Dn57AeDquv8H52msWI6HhU/OyGLIKJu3jvpbJ7vfiLozqrdJGC9qQ
2DKbnLYdKg35/oBL59/rwo7OkVUt5w3DH3gkAOM4t1dalMZ9MGUPll/q

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PwcgrP5+xxYxQdGP31gGMR79MbBcXej15ioHy2Y/irBDqd9VKoDaS2fVjrVkQxYjmbpNfr54QFZ1
nwCfgMwdnwnsRwMCRyuuaGKbQ1ez48qoGbhcj9e1aHTQH0Esr3+ifR2nSUjD5UGjutLpUQpiGRm4
KdEZsUEKVE1WAyx+xTTpnPg7gw8pXHptV4BJF5/hInjaqUrIv/TchUnEmCoOr71TM8oZqU3yRJ1q
0GCRE/zJfQyE9n8QeM5otaeMf3VNy/Nl6ZtYonOCkyRngfJsUAIa4M41a9//NPulqrtNnhuT173O
pIW2S3xNRp8+RGeMo7iXFZUvv4EQJP3auz2LAQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 14848)
`pragma protect data_block
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
kRakUNLtc80rOW3kZatV3MoUmEUNH1Gd+QHl9Q==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
