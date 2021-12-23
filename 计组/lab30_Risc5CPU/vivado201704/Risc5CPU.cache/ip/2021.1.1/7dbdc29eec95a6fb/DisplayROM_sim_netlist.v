// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1.1 (win64) Build 3286242 Wed Jul 28 13:10:47 MDT 2021
// Date        : Thu Dec 23 14:42:58 2021
// Host        : Oddyti-Kevin running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ DisplayROM_sim_netlist.v
// Design      : DisplayROM
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tfbg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "DisplayROM,dist_mem_gen_v8_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2021.1.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_dist_mem_gen_v8_0_13 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 14880)
`pragma protect data_block
r9ljENnZLB6MOoHGdY5ozEBa8UT4wy/8lviIPwuXG0fg6XMJzHLe7auM/eLEzfundfbUldTBRpUV
Sxnu7xCwA8OQIVtyrLU6XcJrPXbov4VspBjnbunBASlGltCab0DjZ//PKvDcghTEfp2Fgnv4Tv3M
6x89yULRmeHP7cR6CfyrCLT742TCUaW8xzNEvf7bLCtz4ZQRTIg/PAisWeZRKPY9fZfjEK57WYsB
9sTAyhAaiuDoZFetQLQv4RzieqKQzY0nKKsNDPdShcSeBKhuTCbi5wLiX+EM0o+2GOMHrubuPbHf
4mIBod2KNjvxpjIMKcYE5FC7djbp/PnIP1l4Q13GN+PJCYetnFCfLKcNAnfLQhkxM3wGqZJWdcDV
//wWEUYqwr4wxS5K7SqH9hT0Zc+mnXErFZqUIqiTFkw3AgEdxs25PFolik27nIrv9Fp25woG8NeY
xwPif6bRl+1oiarVmN2/lOv8qc19gKU+HFX2jfjJ6DlS59LdTBmJIfW4GyQJ9zKzsy4nG5MHGOmN
EQDvL7OEj7e59BG4KeGCwTRtVCBFIbkJvOXDolbtifXX6ftNiCcKo//sQhE0QXfzdu6otf+1NF4p
97XoFJ+pisktgYF2gYdIqQ3H5KN+FMx6QHVcjAGKG+BFCsAnEfVMPe1jvPxB1y9geCw2P2+OqYPo
FXmF4ZuO4VyVWYeQIrsiurLET8+gjurQayfGsk/zaFr6hAMIn6VN4scNqEKWA3UWXrweyNwQo9v9
dbZWkyCXZ7U41DRWXDP69UuYfJGTrHud5KyCyZYqCKKN52pdw+jvR483okqLbtRoHhI+yC05SE1y
UI1gRpN7gSck++aYbdF1quQlohMRRNmPhshuheTW0890mJFfE7CjMO8xn2xdrBTJ5gegI5bxaPBG
J/w3DMgqox1Fz6qLC9ocUQ7I8ajYoVvApJMVaZ4zUjuuP28jS/lzv2Niw2NB4/UIIdkzjiWvat6E
uXNj1OTTSqQte186W/dXI/k5rn9guynHBU/9OJC4Gq65nJfS4zpH892VuGmiOdPIMMpovRRsDb8A
5E90aC6N9Kwg3cLePqLxZEHamBE5vvzqjV8ZXSet2ghfVFwZYnQHSp8OGYJWvwpPjKJIr0zfkdG3
1czyapEa36LNXivGth00XX2RxfKBaR4Ov10murDREWL6KpUUkW+TI85osa/zXLvppB41smeklkXP
84iLCL9YWxVKoUEYBO5jOVfPyctXFy+06DP/AxYEOj2fOrVwNLX0uml2SIBkxMkaOhFLYON+c3P7
Y7CYkwv5tb1G+7m/7CxcPb5aQhXcI09856v/S2GVSYoyU2WPshcJiHhmmVxEADAaVyNaeHxI80er
FNrO64mXkMqhGttOHUGEpQf3eDfsOzqMhRI7GiEr93LIuQNYdWvAtS8gp0jxoQiB3pw+n6SvU6Dc
nETkb5i0KzUxuinNZiogQNRWijUvr2y8DT5sIOAgDlPUInMf1KCBebe+jQURKUfqpzvwfulBBIEI
n7BoaTzJz30FSceffoxeK+6nbWszgEvj9/OaxH+8JFK672v+AccOnqeTkMq4PX4FTgHpmyYdG46f
FG7P2PCLecfb7DtFqd8gv9LLTsJux31RuXtrruZBqWbHq9Ek9rcybHNOrbJuvQiTK7mgZ78MXxFm
nT4M245vZyUruLPiBzLW8gR/D1mcl/piws8AU0KHZywz1iIBubMfwxQPwY1p/0f0m/dxLjPqX+OI
IU0i+Ms+mwBRr0fpiqtXHd5yxjFlsVp+ujhdVR8yaNSS4xH4PXQ28Qy+nckWrEybkmPEHYjI4sGZ
IuZj3TVla7yWhTo0UOk3cB3XH2OwkWI9O8cvtf2jiqPo+ThpKZ7JOsQbU30r4vhg9uuNogHE7AyW
F/TOVOZSIo1rogMqhA0zb+i5xkNpMfbJRMJOZRazO6xTzch90p1iU2IxslTBnl9Ec+r26mf3/sJm
rsUpVMDdhlynwcz9/zS4EJs19FxlCoDFv3u7S70HNgnWGHbqwX9iH96GLshd/4EVlRDsytuqmCSi
sHDnsrA0PLKbQ5e9u8h7niO4THet6z9iYK43CKL6+gl1FUAEt5lIEKZHIQ8D38IoJjDIl3kiLvya
kIg2neqj04BlwzCUBjLaKvU34RJOEB4N5mX6LDDMUoNbj5/iMv1/PaRB8FNxABe8tKHg0HMBXLp2
jUJ1f5Qzx22DmNnmfzZ20gDfsLE1R36KlIruWNtzzMlfKuCFLAaOdlpVdSST1SMQUXi9zq9+UQpW
PEaPxYp6AVCQ/mlbeGapHRDtyPv3sI4wr0giDNDqNooiUvJ97flJSaTSXrlvK9UmnW7UZh+meSfB
VvIRfzTskd4XVxplPzhqHZgfdo53e9IJucNHnkrh7i1AhBYkZsYquNIifjUoWthe+YjbgWI84jVb
nqX9JgRggajzSSTZrYAPeEsJ0APoTUzLbHfzMJYOjStfYcvhEcQQIjC+725y3TmZW+axS1ZiNwyT
nn1xUDsRjVQQi5ZNBmqy0+Az4h6vAMm9kP8/izdl2gPDOSzOpk8CoraRMFASvP9aQpEp7wTxtjxz
LwpeJtNL2Xif9/jgThp+zCNi8VlVfxgIkgQn4RkgUz6EjEn94vUVsD8zK8rxegJVRFJD/T+yKxve
2wYFCYCAkLLxV5ZWLrDIQ6kcSXNOIx6vU0WTy5WUJzmRUoPEzEudHnL57jZrWq5EDjkAEtKwwzqQ
pZXrp+Qmklxnp7RBGj9+Xdrgdk+F6WWBKpMgMltBV8MusDLq5lVF2m1jP5ecdLbyqoUNN6DAawXA
IQCcinu6s7E7N1CwfDKtX8bPkcIyx30YfxE61vewYW2lJrWjIulZKBNzIO0rXIffKD3LoTeIA7W0
P8RFyztVyl2CNzIBPKVG4uOFTgU/Ct4wsp7tcj9+D01BflB53te6/GqT+XEzNnBgPUC79mp/fIj+
0XmA5/nsjxi8gTWXoZ2XZetE1rpsofr80diMCcKjjxhdH+V7f49quhkSSc5GHdFBHDqJLlE5B0CO
FAVDZ6JDTraVBn9MgHaFiNLjqxy/ce2SU8AoaW7ztZdhtb5r++db6MK1H9xT/mg2myfWS+oWIHsf
Ne6Kykd08fbGIWWd8IEgHyQxHcBO75/Qj38+AlYmoUp9sKIug1vA2vRXshx1RnLZRl9dhjyTWt/b
YkX61dgwu0iPr0O3bYsj3iE/+ba54RVKz8EBVtvDezos9SbVzOf+7mxhKjil/B+MTvjUeBnyuOyw
GfSTROPdKGRvFmGtXwb65uu2mzu3dY0fz3+0WjoRbBSCknejRlvEFOaoaZD5Cq6s/jjsOeWi6/Bi
fybvk2MmIB5VxpnUtYUPwZE89Tht2AGMc4wakguXqttUiq3sPCmK+MKu2AqGDW/panyytusxNEX9
pMmlGsxbq0c3coYWWRf1pFV1KZHFayaa3jtMaYA+ysZWvWte4WJdmNOmEzFnmsoYHLwjpULV0Qoi
izB0Wz5IG3KX+Cw7iKYIrPUkms4sqDbPPygI1pAhDZvCy0mMWkzOi5mBMQ2Akp9Zphe82U44c00k
UvujjUBuPs9LDGuIvctlVBpeXuASSZZYConbL6WzxiBfqri6my0/3j9OmiD7B8n4Ch0/MDOXqqH8
R2czT2ju9wPE/0kfK0vAodlVYYAmh9i8RenuLinkWNsew3GqWWOTx1FbRPD89mln/n+EMYCkb+jc
mo4ngNnClcreZlVEY9JY/UfVKO3wHxe7MJhRtxGBe14/1sJ0HPWpOkv2K3/Rkl2IKh9ts6QnKXFb
5//wi5cYToMz1hawkPWXYSKximKY06QRA09tgQyIA/AlLqr0jYr9C8mi2M+Esv2PEKXbOjPZ37Pd
Jvk989XJIfhHYSKAuS4fC6zTDXPHPCN+kVW05KT4i//BHRCNqL2qCnJgzzMafXNKcHvCnruEIFJz
boUhd0G9GOmYIMr8G/KZ+hNBlfXWpIR/lmzIr9gBwoIkKjDJPhaDeOKerh1unW6tt5QFfElt1pwd
QUdbfVENNoqjPQfK+4CGbZLRbuuepUYlk2yZb+qutbjwIkqX/+jwbITR1ZvSXcmBHIbqEuQkY1bb
esp8IaIrmpldfPEPeAzgxErjqunPsA78GTszcmRJUdvthfzC2xsBpmKWZ2LphoD+1NAsknwuF0dQ
X5GMSVFI5MJtC/v1YYLYKyjGimXQLurRSo/fZtfmzRp112gFe8y3tPdp0Ns6D8hv1zWzwCpDKtfR
5VTGSpbbL4sqVB7EuNtLvEsxzoX6zwySMI9uQR1HvYIOyrgT6y5S94ObaRCgenklAqyxZhT56qoI
XCP2w2Mt7R/ueZNSoXThXrQMcXkXmbBo6CQOrWlTazn32QBkijL/HIhT4Bk4oXq2kBLXfpuNQQzU
vNTZSQj0MZ7mAVdfw7Sgm+owVbxyyWjBLPPILAPYTEUUlH0myLXTWtaZ08TJIXoOY5vViO3S9q8r
RRov7KlN70alcb3dDulxoJEAh0uwI+M7pacaLIoP7VrbbV1jdr8XZrGOk9Mo4TpAjxQfD1g14uJO
EUowRDGo1Wed9B3oPRWlyakoWA1lUyZ/A+ZJv9vgQdFZo2rpPwzDX2pyTFQMDmQmdWI22AIMxGnM
fRJcjPrKuBIm1r/J8EjZ5or0OS118w4XzTqjnrBYa15xQDGICw0LuPK7L73KAOyWL7RAwYTUoSIB
dSACHDGpE/ABUmXSVoNFRFB1yLBHAkJha32aDy8gFQyAgr+9B1z9wyhVbSgpuHkQODUlGW3rde/l
7VfwaIi5tFPy60cqzVtrfhrRNf/Jyu7rpj3534iafQSMouIdeLBd6PPIYLueqskhjwSuZOCHyRlq
C8LcstNOw+qhwV51yRK2a8vkgzYVLZ32hgbeOBmUnVBZL+GSlt877R/mm75ffMKmnwnrkqnIDP3b
PPH/cIzX8KVM8NnsVb4l7NTAqNT/EsZAtq4KLKdZHIZr/zJPi6HNeHsE1bObAFol0MMCECuU9MKo
lT2aI1GnRU5kJ4TfGmqP6f92Hk76WMi5RAWl0obJNNfVMk/n8ZK7rJcT8U+xiCyyyMfqiQ6+fGrJ
otKo4gOFyxMscvXlcsubfiIrVZtX2FccQyg/gciQnozKp0d9zzx77O30LFDTix8Szt0Ul5b+0a39
Z6rYqhIWF45zgjhFN72NWpdx1m5xg4cGvfDaXYcraOf5OccRWXIodyalCJtopYt2DuD6otyUDPZP
foW/jrSbbxQO6nILfM79rqZZaRBM52uGJ8Z42P0fN8UATrxn0iYxTvrTlLXl/oTPXa5mIkaD2nXe
zLOAcuRinIYCgIr/wmWt21gtttmlnO33bEIyaLSRWRiTw8Zq36iswS2sjD0gYyALlpOoCTrmUJpu
7svdptm4qM6WYQgQKajvPsB3rlbyRsJin/79/J+TAA6a4h0G6eE8a5qrLN6fwCc/8kzjOzykNuuA
DCTvmgNV7tv6Fr+JUvp5UcTt20R/0/XDTSkImQMXmqGYTPUmozGzeHC2+kMePfX8aCjEC5Q3JC9M
Nx2sj8lYKMnV4f1xIifEvYwotIf+uIwHu+fE4AcheiLfKxXWPA7FEdgWNx8wA+u4Fr0+DAh6rnGN
zDOXrkwhEtqEulb12/vPvyoDTcU6eNRNhT8oMDwQfxTFjaIk3Gw6n/lcZtXpCT37LqaxJTbKn7Ip
5jeUCNXL2INRylQuhjl0Q3izrZ0CqDRuuMJy0rScG35nfQA2dzkr37alQxlJFPgx8Py/7aIjokyL
UyR18icZgmfKJoTOWAuroL5PACbyyCR5+rNxC932qp9LtykDMJqmmnc7rkB87KnCwu//g/ELjEdo
FDOf5JiqaFT1jl+tOYdsbjCburZCX7eTLJPsh9U7rJiKopLsoziefz1aZ4x3C+dmNeKgqlIGQKiq
W3QtC/TPUzXrwqj5kHrl6qYfIFqK4DCjgkk719hWBH6TN7nEfgHp+fRvhjG8+5Ke681MYErxFCq7
ZOQng/QKThruj8DdeJOvpk4Py5udOr/r1+FkePZxn79avprr6rdSjiu61Gw1cAG8kYEKjoYNvM3p
ZfgJs7DddgBQ8/l/Xe4Jl8PnzqL0jAFpUVAkOqTm084eYFRz3CRy6tuJ3VctLjrsyEZ01WMvpPMs
k9FA/KdSuoexneQT3rkkOipJvBVZXBXhBd7VopA/2jS3p9xzaRjn5QBIS9ftjWwJKrZZi1Tpepho
jBbXa+2aFe+mzen8Q+BV1iCDPs+B4URdAK7pWHZWE9GfIltWQqwaUeECYMhhf4Szrla+LAZozE5X
2DxfxeCYvVU4kymRAhPH/CQ72C//O5beD1Q1u+ZCXsjh4wcbKRxtx7dnfw227sWBD7EaD/vk1CTN
odmMIP6yQEmyZ1XUwaEr8vwTMHBr1cLJMu2Z1X3h34ULJYEXfvEa/jMVj1YGFCz/tlHJQF7LA2e5
M13XhdYF/GbSn2xdnVZKjWkD3M4bVBPbZBTxv8lGcasEMsxXD3mc+Zd4Z6bRFY8/Uc18k5FDkMeS
h5w4JJpRIJnEmBEfzX8V8NO4y0FIVw/cAqwwm4nQ1HptPJq/snKrqlTGhUexukuAouJ6AUG70Puh
6VBHt7kHrBIgTv0WBqTXO3IWWthXhz/UvBDE5XisduZJ0ycg5kiRDgVR9Wc69yulBXFOZRftgxf+
IRP9ZifqVBLInH2b4aKbq1crEolyuSgfAMqEnxHZ+rJEkZPuXxfcIzIQUBz+gRnQJ0L5/hW0B7Y2
iYNrtyRYlxZPrOI8DWv/OQU1Ct4dC1LAPOH22wBhsaQII52onTKSV7RSJ3yYP48AibpcUQ0/itPk
8+sBOoljDTBDMcnSjiedmOmd3q21owPhn7zo1hgOerIa31+87n1ESk8zhrokkbzJQF6FPN01dLzh
1k6rI7kcTlU4iXk/9+uIkiJ/yEEeQeLjdLG6tEPOYLuCGWVrloqNKlbiH5bqAtkLlPrEkKgsj7nu
6lG58/QG08qJdYUeOPkxA/dLkQ1EqaOyNVL5gn8gak//Q55fFZKnBQC7+uVXd9XVFUMeww/HLcVA
rcMWlTzSAZcYenpauVvXDOxXo37tsFpZFCY7uaDCR1alGpIRW02JnLfgg0mxL9bpb0JIsiNkutGZ
AYqQvE1BIA2BX55k2KTDdGtud1kfi/ZdEX/vZqtjJsqFUpQ07QuBE1gioetGRtxyA6XvdYwwPjKR
5P4CgZvi3FF3n1SqtGavH63Jczj6ehhifIAOXq03V4BO0XSJRFngoGcGknVCgBFsqrE0aN2t5tU5
IEydcYAxV6aoFZMB/wqvb93AyftoySkpU9qNrgcvg++L4swR2KLXp7Zvr/12D1sKV5yOMvqMU8eF
8cY7YWWaz5OaG6z8Wpx+Xn9mieihLxvBy/V5HaBfi/qVG2Dc5XGR6abNcn+sdHIW8lN+njdit8di
J/zKzeb4pWkj1Np1TWxq9zMZq/aPXAHKx5yMIDoNJrWTYrzS8YgSQTm3rCxjZtqo1K0GpGWuf+GL
kuP9WfoWrZ0Ee4YV9RHrzQyruPeh16KvqC0utGyHC7hJJuQfJUsnMjbpRBPp/x/8mH4Hg+SsgJaZ
HR1PAwOsvMCCPw3QFAsBKosAUMHFPpeVgV6thAb6SKlbASPxlMN1IhRgtGrOaMhYjH8Ug1KcVTkM
40Hgk4pVH45RP+chARBFtGi73WvWAup44RaRIEsbtwmKlmcfo1XlCYKmgdlwY84V214WEy6BHyFz
4paUWwNekD4ilfF4smKpp7qtLL57tdbV4gUx75azlrVgpzWrWxao3eH2ikJin8ajPcB8ZxQCxPrg
D8FKU/HcYZkARCHze/RySmEltgK0V2krv3lUEGhirxLcwTNCKX8/quc3IQBdDJOCXnfDuoGoEjWx
DIFX7omMcIbBRbRIuhlmBKQNXDbPpJ8nmcAotE3f9/LXGdeXMQsd6dGkEcoWgITenib/kyCDVZne
Av2pbu5ndXA6l4ptAM8vNESU+3ybM4g7aiawGHx4fY2GJO6pqKJG/IJNhz62rKySnWlbMSMysTIv
zG1zC0Rdf6JaiFfnsx1Htkf+oMUULSHFSoVHHK2mEJoEU0i03jixXjkeolqX+k2A/730spiH/VbY
nVuc5ZYKJe66yr752ASp6hqSqY99iFjHpKr3etc+MukrAfSZ6omOeeSyr40u45GSh3Q7OBPKEZ6i
PPseR639PRV5Y8n+dXwS8ZXkcH6Th/JoJPvepQ2HuX4YMTfh/xU+35hRLJvQTqsOhFqzDbc7dYPq
GygLeFFxTJR/jJ3CfwztYsaMBvr5OgwDCdWjfvg/r7s6u8PnntOEmDeLhoSmaA0nkl0jKnC5yvb3
uQudM9pIuQ/q0KOt4HrKhs0RO/JqksA6dY/RnXpaeWF4p/puWmYA0ewNnmzzZIGM22RrC1DSyFW5
q8Bw1D9CpmPhG1nr8+Q5XbD01RPJRTUfpQqtb+cGFeYWTviPX/FsmW4yrBX3ZQ54KRbY8XjdCiFp
hs12Pv+0Jy3gwE4x+NC2Lwdsb0YLnQRKKJ3pGr6FcBs3MQHPseW4ZQm2SDFqhUarzlTU+ww6Z1Ne
dyTaeHKitBUSMfDK7dZFmNjbgb1WzymCv06vOL423Pnf411swYiPpxCq4o9Gu55Y0rnmL5le5F2i
4/CyrxOgD2HMk+7KIOEKOStLyJO6tPTgIYzshAq5ojpyKjbK8H0XhIpCrh7BaMic1IQZzeAteSZQ
c+W3AIra1DoTU7DeKopZUkUPwDMSYecYFZjSZIyvyBbcTWggJhoyMbQgbxGGxb8KTrFDO+BNuddx
vJKyKq2dblGiVm7F+1V2zCB9fXVJ1ZrUxBjS58cCcT/jyxBamEmnIALCsQRBtffrPgR64acj5wrP
CKCdA1QpLjyB8uUO3++7DAMQvmL1UF/pXdLYw5JTaODfCAIP6QFBXJ2doV7bcnbt9ipqx2Li+5hN
6SUr5zKn57cdrsg2fwRiE6S6dYbJWljXvnme/OvzNI3IzZZLihg7PBRiCMu8rtwxH1Ul0m2nkJS2
yhNOSc+4+a8czO7WAV7Cw8v+o+OCHMcB1Ghod7htquMZaWlpZCxbIaCzgMdDttkCPXy8d1h8/fvq
i9f6z+7jpiWp39EJ3iyEr9ZoKjGZlMrc7h2H8XaAmld18g+kMrOeKy5g/wNKle5eyE5QfRJQVmdd
amLuLoFnkfVOTlyf34hwKSiQdkhpaWvXo6e3hYNhXTXgRYBE9WH5/6APRGejyXrWDtm1VpRSyQUE
FmxhvnKRyrLoFNu7QHvJj2oB8JWcranog5h1DkkYW/yep7PDXIds0dYRWT1dwvvWWYKbT7PEZYNX
x0ZkqjWYSl0pBHbWGgSQbx003R5e28cYqwYHgFzfVPPRm+M18/k/8qOolF5qrr1Ch7I1OnyWGfOw
OrMPvD7xHtipIhriAVQL74HlY0rimE7ELKjX6wlGwwbf6TQpUXSyPi83RJATAuJ2VvRr/iz0VqK5
SfCLgTGRxqTfja20UP2e4o0L8xYjD+g6BAIbIXdUMLkTXDWHPbiaTMBqd3VuGv2ehhbavcjEGztt
ofdB6Bch5Mbx3MzsI+vNX6U01pcwA0KX8rER2VXTQkuNJRWB3eFP0n9CuOLeBcj/82YcD+rUo/7N
gGvwtd4eJHJeWZldzqI/VebesAgsv68/N+URcWadSDLlrx2RGGj1ZebR+NnbVipb51ag8DTOngr5
ZDC0ag7mYwE2Vp5RTUwwc9tBC43OxtiRbg4jyniuFhSXpQjlKlpOtqJnWXKk1QezHBhsVBUNHups
msEZagcG+cwmGaty/mmBHGJGdiGEFmjfSRCbcg9AiDZQlYuvyuiQ0yupO9X9x5q2jEOnANegBp3u
sn/qScKjekgLQ7XvsZA9fZ33FqhlSqQQN1iqlL8M2KMge02jkdLcy4qUQoqpl5L1kgP4UewkjgGC
f+lybH8s2REVMin9AwZKMeMZzeA5ifMrXeaBhWxJyFQtQvWuO1H9thqGbnjm3B7uOtwSnJnNTHmd
syxAOtz/87pwfxfLGbKjRzt2eZftwb7SPu01Qp02kdEJAIMaeDtKIRj52MHUjwMf0SEt/HMgtmBE
JJi0ZfBYPBeBHCOileCjYBg0BPXiYmwXQtJNfTpm2KaOmmLjZ1UJ/WdMX9SzhFeVAtn+ETzxQD6n
X+CBBWiM713+MZdczhOM4GpBZpLS7H+eNMPtiw0jvQ24U5IxYhs66ptSyXhqIolvikThS97KQ2zf
vAdd28174xNQQUZECV3USByIZ9XX4UP3NA6O8rDVKAy42VP3T5HsjdmqTBCq1Vxo/6Q3BwJB+d9d
wrnJNcYkL/8y1wlcmA7oqq67keJVuZtRZ/f0jKC+AUPlAfhz3c/olBbjrgUq4AttAI/du45XDbnD
9/DkPoBTbTtdO78cLp1/Pkz3TGWSnQpUkXqdMFfmHiMX9mGIBsz25/Xa+2T1kD8V1FAAJBzIln/G
mN5HBlqwCFNQ8tyAMW1c8VS50pfE9kWUHUAwwjIvMLptKvduONqdvMqMpUokzWZcah3ctbEyxFpS
oDI6EOO1N5tblclMWh+E0Ctnbyym+B+rD/4NYS9yXpZfaVhyy/t07+8YnSM8HDotHadHrZH30z/1
bRzJaXXuwI+owf0XICoxLEbol8zCL8334HYFdgRXSfZpiKsRoaxRtUk4KXUVa56IbQbPjm6s7iRT
zFgbY03QxHVoAN4TPzerGNFJhr37GwUFS/2dKmY+g38dWPC1L//y12jyLllGZJWFXmzWWtifNFIN
j0EMMsxOmGFKTMYS8dKe/ezQRB/8DG5Oe0HPweiwoHIftvi3p9X+wmGlg74cXjI34kHhAn9EIKON
0eLM+xoZaBLPDK6o2AgAHNQGbdjw4syV+pGU8vOXFbORQ0SmTiIzzhLNSyW2ngX3dAWj+obwVp5Q
rOPPOjtrjVVGgrR5c6cIBiX+tB7lcsWpJkwviA/5n7aX8hgiZ17m6bSmTGefDspXMmqJhVUTOjS6
T3kgFItiOoAijSUOO6LpHFlTySyJ0MtdM/SeQkxzcuMUJQvFdVW1F0C8wKhF0e3UFLD9WLivkWE0
uayTmyOcKxLeuwf9OVByHGsQ2NcaLbiNnjDnhH9PbIoA4esiewmbpUIIO9ebXyhj+OF6np7gzlFk
fW87KFLVamgB+Vz5sUkcx03dDYx9/ahLzhW6iyucvlop6AbPpdlTgcpDKzkPUIh3oLvTSW4Eppo+
3sFwQ+cni5xryI3eAOMp3wKS6L5P6U2QUg5FlLb3ELb8L6+Fah6KWP1hx8Ta8c6v6T+00ONuTqmP
zR4YgYxJcG7e0Q3qOvWCJ2VR666jwmVACBJTQymhZ6JrROv6/s6CgDBkx19ghn9nufz8fypa5X0/
Meuh3LprM1trJprbvQ8SoNMfl76Z7iGfJL8OCvyYKvElwbHDCSGrukeEguH/nuFTeWCVfqacMmeT
9kal6rbGyb3o5ZEDiQgQcnpTZDaPWAiGLb7tR9bnyPqEQKOsTlI18j2rwm5bFcSby+8E9r7xi8rr
27CP6UyfRz6+DtRtLbpIMoWrGZ8GVEx/FvLFgAcGWfzuE8g3y8YU/7ELgDkIO5DAWq/JfHF3Vu/I
R3LVPmr2g+x65JQwCH71Ua8oh6O8Z42ud+zp2n9UvRPfFae/jqteZWikEVzC9j/MYd5McRdk1udZ
IEx38/y0WeTBerKUf7cS0lRXS4B8SDlE1Lrb98GlSPbvFvFDdSeZrdszXi0TN5J9FRYeEUSYQ253
WdCg8eWF7f0NP6PZkgFM5uVx9OtTuNUZ0HrpqBKgFSnjU13rVWX0K3b7A9HQmF1VBZ6dD5MJAeV1
8PniFfp+c0WzGilE8vCa4Dlhw+SBOtKeUTtHMtSZx3fnyt90dfBMhak6Z3RJPHsPJ3wx6ZkWSHpk
wpmgOEeBqqzHCb+IgTpS2CzhQov0Pof76uiB3zBEvDPS74ecBOtpGRheP/bZtS6dkV4uo28oNoTB
nHJyOaS2/UQ0EcJzio6O2YSOS1nv5ltPZjK+MDFX2bwTG25lKGUt9DVap52UzzJQd1tbPkhy5S8j
p/MRmMf6IiZCvI9VSWxxv7dsMifWbiZm8a/A0vYCcmAgtZF5FYKdyLBBqy3T3zOjMfeWelRvT9zr
S1p+re1E6It13WTfG+odIakTOzKUhIAVe5Q1dARlHw3egFpffAyypQXhYQbBzvJRuEbo4iFCku/N
+TNZR019T/w/hF3zS84dtdmzg1h+y3BVA1VkBbjmV05j7FMeDwKJgenAeBw48UiJsY7i/i1KFUo0
7mCSXIUcvBZc2nmlLBpqne8wIV9QXbgiPNxXLmGqEnKPr98wLcEESefWwYkNwcJuHkZzbNATE7ef
uozK7CRB4YIgnaJqLm6zDM/7pxauI/Ylh7UJzJ2xywvXdUfmN2+Mu9ZW5TO/bP1p5erJJtmtFvhb
/kTXb4SREo93rNKjEYVezXu8GNb4bDbWxQrjRa7CNjxZZEYlTKuQ4cRztW2N6FYby2ucB+4C1MMO
DgwTUMlzZpZklgApLgREGaAOvzeluay41jRIO+5jM6l9ROHO17r/r5vNqE577x/HlDL0baAjSD9e
xBdkAbpvYEMbbp5WmB3FibbTdlJrjWhIKOxghkbXFEo1vexvckMxqZITj8jtcBXvNS6Uy1yBUpzE
Us9vJKi7/Yvr63KxFtaxEtD7wp5V3+usgGDvO3IAVZyrW1QJXy1WxuIS+pAEoOvJglk/TY68ZgsV
MMrJP12HaOeg+i2EoKIgmL2epMSiseZeDXrOl1hsBTxB8Z+He6RWC/P1U92We9WaGlRGrSkBMBhp
OZCf/1YUqf7xTDgx6yOFtY6LiGepKKOZVVzGxLgiHjLj9wQ41/NCg80Dhf6WzMFA9+awt16+wft6
tGAN6judH0lv5kVu8KnB2GcaIX5pdKD47/w+Bqziv8nDaFcQeNpdc8MCsRvgu8c/GzZ5qMoWBp3z
F6wNv3WcyEResxDLLxN+0Ix9eOiHAHDI2DOpiVt4qHHGLaBo+1MQhZVuPBovBHIo6h9ozWAJmUBK
ytCXhTNU1onyiV86vvnmqd47D5/Z56yjCkSD9FZJaWQf59D3SgIEqMsRFUDiYTBkjrh7v0UB2PrV
RLcecLgEgWqekScH9QufUGl3F70h2kpKq0vq4GxfTskAUJO1qp8A8MLND4NF+3kewrivFIjNtfmC
i0N/EG2RDbfnLA0jExJSiQfq9e2lmO5o+W2vb0YnpVBqlGxD3cyGVs6DMSxzrbSGA56wCjB11jD0
kVrGSzo3hNwwPg5Ta2BivkoBCESqGCGzblWQmWFHdIVTD00bap1B//lPh+uL5aVUge+wLVt3E0gj
cKQ//6Pg0q4zjULoYG4f1GaXbRUfX+2mKumiRLfImpsVY1jt+jQsZfuv8Cu9hDUIOXYvuhWOf7E0
AJaAMODXNKzha84VkZyGnP8qOeqkGT8IjLRgEkdfrbVqQzUjy1XHhhUQUb7u9ix3cmFVD/GLbZV4
EL6A7X30VY/NtR2o5s5mT3i7k8LxoTkhMrqZ5ZnltJYQ2LgmjHSIzh6BavCiq7FAqzsn4GOXFRlY
C8siMp+7So6XRAc8A/R9qa9PKGeA/ukYv0Y0Rpm/sgzPf4X8H/va3Tu3j0z9le2o1cPcitlLeKym
pb0N8IUQz69TGCaXxKlcur6SqiKH1pARLSJroy5f9qvxH8S7sq+Ezl9QOb9qlJmatp1em5mFY8sU
aZNuz26j5LyO6A6HK6sb8vBB6x0yl9pAWM1C0zt6KFFWHybqy8yj253trJiFrygWJU4CE/EpVvm8
jEhpPfTOYH80hzp1FfNZPcNGMUzweHKHaDBQWgJlOlEV6qi0KilhyWRWYsPdsdYTF0cQwt/lBsni
BWYqkcuJLmYQr4/g4IDKsYHYYebFQRFQ+XVbcAkGG8LF1loGzDmcFhZeZUJIwhcSIWgluJekhBD+
hjEjatR7qxXs4yHut2rmOLgfKwqwHoAVaMdrpIT6sx4RvXGM/5SBrIKOKU6KuypePBaOmkNJkLwI
r2f9PqkAZjL5sFtKpreMO5HkXd9eqOszV3NWMj5zbI7GZY53r7Fk16ZEv1ffAS8njtsp830OCs70
SybDmBzypPP6O07h8ckbMUIAve+KK9ycYsjhAsy3q5XplP8wGyzVkwzIQH7RjFj3gd+tt+cfrGw9
nIWYRGmyFXFP5GAwwF37e6fDJviAktXt7D0pUDN+p98qGxKVTOUiRUQrkuI7Q3lktcSB8mjsqV0h
y2/manH3skTfv+dIfTNgtZLcgf7mwt3KaHuH2wvMmCkEBGUdwyBJwtLfo0pLtbnCqvKOBBdFTMos
o+bM9BxMROUOAxwz0dyJ9HsUu9WwMpA4ABX8xU7SlWJcCOItHmDY0AtdapS2iG3X2A19tO7rOkIe
+y82i7NQS2/BLAT34cnJ+6SzvO+lKDlLvIbIJP0IzuaxQmigsJAvwcxTJEi6dQmi/6LHxqvztrsS
zsQnDd/wCJzawaclFVwxwUhk42f2h9GSO5rdzWt9s66UOnGoOIOQccq7OYj275Lmiu2cmkwN67LG
AWRR0wAykSEtvN27sRngoqspKuvAa80IWN79lCvoxBL1EeyXthHXAWqz3AAjsbNsguubK5saTYZd
BI4swI4igxWEnXh0/81cAzDUF2XJdX+U3BJLbCdwQX8CHjic7KQrAS6d8S/Uz8gGUiR4DFcGCLX+
SGkV85RBas1aEiuc3BO8mAMrRNtSjcFQprBKEQ1pbDGyH9TusmjXj70ZU8xmOmLGyTFKh91bo1H/
FwnDvGU9Fl6VQw2pvtIQGQO72OkiftP12woruwRxgQw68SPHflP1zSRERMr9utkOHRFJ4grRM8Zn
wYz4Mm/yyLZa0C8N6VasOaEWmmhD7ScwoIFNnvBWS1cDB6DNdYekPI7P8esSoieQVmuZEyMwT3ei
Tajq5o4ic7/VRnlTHk0+aTbRjIPjVIXyg4XHUct3hJzUFFntaGymhQN5FBx9ahkJ0DEhA1j5uANz
3o+ui5M5CUfN50QRYOyVKjJbLTjrwqdEabRthh1+rouu/fFDSFESqZh0KTNjjosIXw3eRHrGv5ca
2BFgEE/5hWTXXmtvsFRDUIYFt+QSeaq2lUh4dfbJ8MOZ+gMBLm3h4MSVW2imKD6Nv425qEcWtU+T
j/WI9IyX65Xv4RB5rs/gMiFqg2uejh0TPlD9Gup9j7XJHQfSA9DHk0j+rY88YY9MDF7kll/naOUJ
ckSupCLWRoZwJ208j2M+nnUocrK6nV8wT/mQdZQTN4L1nR7ExPN94JYmqlw942YpIAU8sb+Yq4CB
Km4twa2K0I5rLGG8yWoRCLNv7CVgJdnH3JHTcrv0skwzlTBD4/D+6mMs6PlOAeg60uLNR3g6Mnrh
cA6QTvRi+q8HG+9GMds1RAtjbpZBD/N3b4UmLAssKXivL8OkKCzAn60SpVHlbbxc+YCInT32RXZK
ndohXdXfqPeok9eEzaTkMlOzuCSnFiWbtkwZZyhK58Mhx92wZWsK8NB+OkiHRXIvgr+NkCSFnk8P
Q35EJkWvaFm9lTq1xhHECvvLcixlSS1fCou/+zMTS4rGxvsHuur5POyLqii8vjN1G7j2EsdZQZIY
Xzkd9ptDxcrsUWw38v2IkmXQ4JPYpX6M/jgIvfcET3CCwwfhv8UGJEqBiGzjukN420oUI+JsAV/H
/ZQZKZVNN0BNRSlM437Z7KpZvSqHuQTUH58j5KCdDpXwStsctRWoNeUXS4QrkiZFVlQjVyA8W120
oDs4QHnmkr+2/wTguRasvoMn07XCM4ju/WiieBfl7L2ggBKUArShilU5Dc32iLOErqPsbJY05ubi
pMegAoqAQw4eevwA76Su+gQAnR4XCoyizEfZRyQ3CKYf2+jTTs8ltR3oEqoR1CmB3gN7JoIYwAYN
uaAGwOC9mFHz5hMNxDnU39My60DkqfEwi8uk7zeL8firYeWI3vYZOaXN0tWgB/OJLn6/iO/peLtC
CzKmJg2I3Pvg/CZ6BXxqzRqeCUPdNX4EEimrweWLrNcbiCbtLvbysH8xFHza7x2doWLTQUyeoM23
Tid9OyWDNkqV4TMuQCbpKhVWj8Qw7V04BUfqiqQ1884DvS1SOcdH7AXVUlfI8sjA7JfKy7kBKfOE
IPQgQB+GCTqDmSN3np/iGztV+d6xCgxQzzITX34rDnhiw1PGLvKhydvR7D1cowKNsF7C4oMvQ1aA
3G4cOfsd/778mFqWJQchLEIXG5+ktPI9UDNlXsZGQ2I+Jqtk0LmXugZr/PQFcViYlTnovlj76YHO
z5j4uPODHfiZv2qa0zB12Tp4ve5lSbwMTNMEN4n5m1DHiUsC5TnNTyrDiTZqo+zw67qQ4TBR9KGA
dVXvYP+kVJ03u1NUjPlNP5aexLlafpg9qfJEzPCFOFTzm4HDpCoH74JNCZNxnNsrLsceMgZTM/fX
Io3TjcPd0/eGs2BTaueUkT16nuIKdIfzkn0zIlqDj9+JRw7/pPuIcXDQxwh0hngocQ/eEfH/96Wg
Bsl4VDUUiDWfzlN0iuQmrCLRMZcYYCmKuLBWAzFAeFUXxTcBeGhFd8+H0T84Sc6jwCt4WRfxRlmY
/OVbcV+2mX2rBL28P4NdyhuZxGlKuI+s7+h8F3NJOPcDkZVG/Gwq5MypeR0F9rlvDylRjNmLlRsB
aRSCMBSO4nnHK1P86tneZ6JI9MU04nk/tjU/MSgbNnAKsag9mmZUBUjNdECqJtR8fxuVH1ICi8uz
uwNYzTIWQk/iZ0drCWtRZP5AhHpCM0deMLRmF6C3TDG3wLA4e4s1bQ/IDGyZ9G4cUtwkB7HtC6Rk
gCI7ZLucwvoKXunPNXdx6mxeoq9ZYzz97Iv2DweRw8l4kw2WFQA1Voa4cU2pYy0y/rn5yaKVr1kO
kObRiH4NIiOuvnyx6H17fs8wVY5ksYLDBUAlR6hEPmv4jEC+4RNnorpCOQjiqG1smjVRsmAE3H+1
QTsB/6B6C7nRHdcglUOjmyFv5HczXtSsjma7nYLhu8gz1PyqtWV3cPQM75nnmukC42ggNE5h5W8b
xBqNpKCUJSucU6Q6SG9Y7t1X+xeQj1nYZAgQLYsuN3djIbMnQ5SXQo31iJwttxoImeANoKz4M5IK
dGzqJBhH1/l/XjPZusu1r/pLucPQLKPjt7biyRJ8AidNFxlUpALNFsJTJ5ddIBlhmGvZxL2LXDnR
sS53M6yjMQxmhybNCTWQ3qrZK7BKB5CxqVMUMClQCwEMl/QsJ4XzJG674dJmG2gOh9OapWKPdz0y
9HZIPwB5gTkZAjAyyP4P22mrM/b1zjCo79OFv1HIkIS7E8ZQqHUH/1DgOsz034mRXDXjTia6VjE2
j6XmEFP7Cjnf6ef+j45OI2PgE7bSj3zliBKjLGlfSri1xY/YnrN5WBaS2BfusagzDupZPVkY6LDc
BMyrtqV8HY1bVBemPdH8R5OLSaMiAm+ta6eliJiTFGB/JR6u2CXpTwV4yT3AQ9hfb1wdlNnrHx/y
46WEBzbc4Uu8iXZXRWXSnm5v3NIHB76vDDwAxEitxsK8/+JKmL8YCG93alUHegQzeQp19plpMcS0
7Lf/vk6Preze7gwYNfwd09w/kLZxG1q2KkdYW3HqmuOoFjATeWg/ZZCJGBHJ0/gImyX73u5WEQot
xsPQuKfMRF6l9jQwg4BndCTUuG1+quh2moEyVOQqfC/Ld2LxViTKW/fY+SwLcLbrnYJZYoDMtlof
dBwiRJUv64V88vmPd19kPNgqji/9vin90seCKCS3s5e5UrLQTqcKlf3J6lHNUwscPXJGFp7ZzwPu
qpA2rnFBsOvsEXqkVply/s03NMYmrAkRy2UAjj27Jzcxh2Jn2t1Osco1+K2LmcLHaFxEk64c7Ybe
8TC0dmhshpEwHN+zeUNTImB7BFktZ5nvMaUvBE/qcDkcQbm7ZHXN0raF3zzrBQzs4pvmb8rzxO2U
EJaqZ3oP1yLqEw7CJUxo8sL7BAwza6mbIGq+i50mKb1jBiXdK8iF43nflIsBpVPRqpxtgzlfbmXw
35m21PcLA9gEsbT2lVZip3yIRK9hZIufNULYBWnb1IyxlfkjeUKkq6YsbB0E769Y2F/sCn2Or5hh
Wt9OO04DfwyYC3f+BukuEf8jhBm7TMChWInwhjpjmWQ1nKQ6Utl5DDM/6aD5WctFNj/+FtVI+cMQ
4YKj7Er15KR8tNMslqlq34LTVC9E/I2DdgTogrjg9iwzmwuq985WaXBe2o9A13t2hX+vzQof6w0u
8pvsrLzYG5tbqH701zrOiLgjgJWDrNV/axTD6k3Rfvn3+eltD9N/lQRIEAh1GvsXIRt4QQzkcC9k
ls0ZUqVYb/+S0SOKgXtjkDXU0j0qMee++V8RE/L3S4iy3fhmEsxGhp3n7qCMH/ip3RqN3QPl5sGR
2SCub7+TDIMwJqKw59jJRhG55UqnxgbKQdz927ZTT4ZXhGdDbxYTPpWYBnvp26iJ2liKuipquQSq
u+MvxsyYDGj0UIl7cHr7karI5LGbuIuNd6NhH5JtGrP/ThVKcfb9X6guh5vlcTKskt0q+7sQ1jw3
SzmLJtp6kKXMG+HR09cPbXwCPpF5NYO+rEUQ829e+iKnUnvHQdcDkKAT4zzA7nzPnvacnKQMg9rS
r54EK5QrfKME1bAUbh4qRLrVy4c/7V0P/MbPcrUi+9zYrvs6OOgdfMzHiskfqTpJcoApNVSCP404
5sdwwRj2J0zFzjqfiX0cQeTwgKEzl239Z7L7l/lOxUJuXHjX0KUkwJbKU3la3td6qeawjhYCrfyC
zEgwcuDcl0JErS/5D6gudiT7PkrIgLRzwhJ5XI79TkuhQsehp8nMdZyypru888ReJ2AmPehL3+5/
+SHqkl4/oXYaf2ULHkzOa6/R9Vul/IGybW+OX6daffUQ+Rhm92yg2f/PXW2xIe013t5975F08mF7
rfAIcy1RhhIPQ5IALh1sA9yxFgwRP8iFRq4/h2vDixD4GwyNMDJ19apAtexz0Hg3XYeXTKCfagyn
1mCCmxRkOU67BCgHCSVWnkCXX3IRi/8CLgT/SFX+ZZ9lwdj8RvTs9LZx6YhsgabW/+qaIMNJeSdb
0Ib84vvVsEHtRn9tegiE3Wnaga0mJ0n7kSQISjde8mfnTF3cTUABUTeA+vfStpHlardfQQZ5NqZo
0tyz39jp+iPYcXPzqdFJmYcxM+QTgmtCgLcyMKNWqM8eiSRUGmyus4OpZojVtb2yoz68WBdad8wU
oGjCw5vtEbGrlO3xwwQ2zzkS+geLGbuG/EMhMtvSktE2hYHqnzxf3u6qNZIXtFLzq0xBfcf9KDen
COlJot6B8viN9bmP/+nTx7tHli8gWUFMsRs/zzFq8jO5jG+VvOHKFuwufMsSu01ZIQBxkLVXUj65
wG+FrUuas8iwcAm2j9tX11WduH4JU/vOlJHjSIkrFK0SiqOW0+rYr5+AXZmY/hvAPn0brxeKaPKL
aYLwoHOZAMWzSPujRYDEQq/FT+lL1e8YogdXF2M8Z4b9zrb0CFuGRbSiPIZp0oCBWmf6jJ5zFrmv
EmHsWKayJOlHfq6NAafB//4ZsTFA0dzvlBHqtuFO9yzLvPiC991UX44c9A9xe0nI9DcU/SmaEunC
cDVsqHw8iNDnDKXe3iO89QCf1ZCR01naO3LcDpqjFBQLNHi+Suc4giaFWewy/dCr6+0X6aGtLYaH
Y7LDmtkIg4eZ/26Ru8ZNkpG5HcJI/FG2AVy/qid+KTXDKKukasizzvObufBCAhSVF/1Onnizb19f
6QeJ
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
