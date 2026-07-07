
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.0 [get_ports clk]


set_property PACKAGE_PIN U18 [get_ports resetn]
set_property IOSTANDARD LVCMOS33 [get_ports resetn]


set_property PACKAGE_PIN V17 [get_ports {data_in[0]}]
set_property PACKAGE_PIN V16 [get_ports {data_in[1]}]
set_property PACKAGE_PIN W16 [get_ports {data_in[2]}]
set_property PACKAGE_PIN W17 [get_ports {data_in[3]}]
set_property PACKAGE_PIN W15 [get_ports {data_in[4]}]
set_property PACKAGE_PIN V15 [get_ports {data_in[5]}]
set_property PACKAGE_PIN W14 [get_ports {data_in[6]}]
set_property PACKAGE_PIN W13 [get_ports {data_in[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {data_in[*]}]


set_property PACKAGE_PIN V2 [get_ports pkt_valid]
set_property IOSTANDARD LVCMOS33 [get_ports pkt_valid]


set_property PACKAGE_PIN T3 [get_ports read_enb_0]
set_property PACKAGE_PIN T2 [get_ports read_enb_1]
set_property PACKAGE_PIN R3 [get_ports read_enb_2]

set_property IOSTANDARD LVCMOS33 [get_ports {read_enb_0 read_enb_1 read_enb_2}]


set_property PACKAGE_PIN U16 [get_ports {data_out_0[0]}]
set_property PACKAGE_PIN E19 [get_ports {data_out_0[1]}]
set_property PACKAGE_PIN U19 [get_ports {data_out_0[2]}]
set_property PACKAGE_PIN V19 [get_ports {data_out_0[3]}]
set_property PACKAGE_PIN W18 [get_ports {data_out_0[4]}]
set_property PACKAGE_PIN U15 [get_ports {data_out_0[5]}]
set_property PACKAGE_PIN U14 [get_ports {data_out_0[6]}]
set_property PACKAGE_PIN V14 [get_ports {data_out_0[7]}]

set_property PACKAGE_PIN V13 [get_ports {data_out_1[0]}]
set_property PACKAGE_PIN V3  [get_ports {data_out_1[1]}]
set_property PACKAGE_PIN W3  [get_ports {data_out_1[2]}]
set_property PACKAGE_PIN U3  [get_ports {data_out_1[3]}]
set_property PACKAGE_PIN P3  [get_ports {data_out_1[4]}]
set_property PACKAGE_PIN N3  [get_ports {data_out_1[5]}]
set_property PACKAGE_PIN P1  [get_ports {data_out_1[6]}]
set_property PACKAGE_PIN L1  [get_ports {data_out_1[7]}]

set_property PACKAGE_PIN J1 [get_ports {data_out_2[0]}]
set_property PACKAGE_PIN L2 [get_ports {data_out_2[1]}]
set_property PACKAGE_PIN J2 [get_ports {data_out_2[2]}]
set_property PACKAGE_PIN G2 [get_ports {data_out_2[3]}]
set_property PACKAGE_PIN H1 [get_ports {data_out_2[4]}]
set_property PACKAGE_PIN K2 [get_ports {data_out_2[5]}]
set_property PACKAGE_PIN H2 [get_ports {data_out_2[6]}]
set_property PACKAGE_PIN G3 [get_ports {data_out_2[7]}]

set_property PACKAGE_PIN W19 [get_ports vld_out_0]
set_property PACKAGE_PIN T18 [get_ports vld_out_1]
set_property PACKAGE_PIN U17 [get_ports vld_out_2]

set_property IOSTANDARD LVCMOS33 [get_ports {vld_out_0 vld_out_1 vld_out_2}]

set_property IOSTANDARD LVCMOS33 [get_ports *]