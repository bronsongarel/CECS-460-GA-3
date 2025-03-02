// This file is not the full Master xdc file and only contains what is required 
##Clock signal
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { clk_master }]; #IO_L12P_T1_MRCC_35 Sch=sysclk
create_clock -add -name sys_clk_pin -period 11.11 -waveform {0 5.555} [get_ports { clk_master }]; # 90 MHz clock

set_property -dict { PACKAGE_PIN <pin>   IOSTANDARD LVCMOS33 } [get_ports { clk_mem }]; # Replace <pin> with the appropriate pin for clk_mem
create_clock -add -name mem_clk_pin -period 15.384 -waveform {0 7.692} [get_ports { clk_mem }]; # 65 MHz clock

##Buttons
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { reset }]; #IO_L24N_T3_34 Sch=btn[1]
set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { w_en }]; #IO_L10P_T1_AD11P_35 Sch=btn[2]
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { r_en }]; #IO_L7P_T1_34 Sch=btn[3]

##LEDs
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { full }]; #IO_L23P_T3_35 Sch=led[0]
set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { empty }]; #IO_L23N_T3_35 Sch=led[1]

##Switches
set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { data_in[0] }]; #IO_L19N_T3_VREF_35 Sch=sw[0]
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { data_in[1] }]; #IO_L24P_T3_34 Sch=sw[1]
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { data_in[2] }]; #IO_L4N_T0_34 Sch=sw[2]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { data_in[3] }]; #IO_L9P_T1_DQS_34 Sch=sw[3]

##Pmod Header JA (XADC)
set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { read_address[0] }]; #IO_L21P_T3_DQS_AD14P_35 Sch=JA1_R_p
set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { read_address[1] }]; #IO_L22P_T3_AD7P_35 Sch=JA2_R_P
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { read_address[2] }]; #IO_L24P_T3_AD15P_35 Sch=JA3_R_P
set_property -dict { PACKAGE_PIN K14   IOSTANDARD LVCMOS33 } [get_ports { read_address[3] }]; #IO_L20P_T3_AD6P_35 Sch=JA4_R_P

##Pmod Header JB (Zybo Z7-20 only)
set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { read_data[0] }]; #IO_L15P_T2_DQS_13 Sch=jb_p[1]
set_property -dict { PACKAGE_PIN W8    IOSTANDARD LVCMOS33 } [get_ports { read_data[1] }]; #IO_L15N_T2_DQS_13 Sch=jb_n[1]
set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { read_data[2] }]; #IO_L11P_T1_SRCC_13 Sch=jb_p[2]
set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports { read_data[3] }]; #IO_L11N_T1_SRCC_13 Sch=jb_n[2]
