# #############################################################################################
#                                                                                             #
#  Created by Genus(TM) Synthesis Solution 19.10-p002_1 on Sun Jun 21 13:06:57 PDT 2026       #
#                                                                                             #
# #############################################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design alu_4bit

create_clock -name "clk" -period 10.0 -waveform {0.0 5.0} [get_ports clk]
set_clock_transition 0.5 [get_clocks clk]
set_load -pin_load 0.5 [get_ports {Y[7]}]
set_load -pin_load 0.5 [get_ports {Y[6]}]
set_load -pin_load 0.5 [get_ports {Y[5]}]
set_load -pin_load 0.5 [get_ports {Y[4]}]
set_load -pin_load 0.5 [get_ports {Y[3]}]
set_load -pin_load 0.5 [get_ports {Y[2]}]
set_load -pin_load 0.5 [get_ports {Y[1]}]
set_load -pin_load 0.5 [get_ports {Y[0]}]
set_clock_groups -name "original" -group [get_clocks clk]
set_clock_gating_check -setup 0.0
set_input_delay -add_delay -max 0.5 [get_ports {A[3]}]
set_input_delay -add_delay -max 0.5 [get_ports {A[2]}]
set_input_delay -add_delay -max 0.5 [get_ports {A[1]}]
set_input_delay -add_delay -max 0.5 [get_ports {A[0]}]
set_input_delay -add_delay -max 0.5 [get_ports {B[3]}]
set_input_delay -add_delay -max 0.5 [get_ports {B[2]}]
set_input_delay -add_delay -max 0.5 [get_ports {B[1]}]
set_input_delay -add_delay -max 0.5 [get_ports {B[0]}]
set_input_delay -add_delay -max 0.5 [get_ports {Opcode[1]}]
set_input_delay -add_delay -max 0.5 [get_ports {Opcode[0]}]
set_output_delay -add_delay -max 0.5 [get_ports {Y[7]}]
set_output_delay -add_delay -max 0.5 [get_ports {Y[6]}]
set_output_delay -add_delay -max 0.5 [get_ports {Y[5]}]
set_output_delay -add_delay -max 0.5 [get_ports {Y[4]}]
set_output_delay -add_delay -max 0.5 [get_ports {Y[3]}]
set_output_delay -add_delay -max 0.5 [get_ports {Y[2]}]
set_output_delay -add_delay -max 0.5 [get_ports {Y[1]}]
set_output_delay -add_delay -max 0.5 [get_ports {Y[0]}]
set_max_fanout 10.000 [current_design]
set_max_transition 2.0 [get_ports clk]
set_operating_conditions PVT_1P08V_125C
set_driving_cell -lib_cell BUFX8 -library slow_vdd1v2 -pin "Y" [get_ports {A[3]}]
set_driving_cell -lib_cell BUFX8 -library slow_vdd1v2 -pin "Y" [get_ports {A[2]}]
set_driving_cell -lib_cell BUFX8 -library slow_vdd1v2 -pin "Y" [get_ports {A[1]}]
set_driving_cell -lib_cell BUFX8 -library slow_vdd1v2 -pin "Y" [get_ports {A[0]}]
set_driving_cell -lib_cell BUFX8 -library slow_vdd1v2 -pin "Y" [get_ports {B[3]}]
set_driving_cell -lib_cell BUFX8 -library slow_vdd1v2 -pin "Y" [get_ports {B[2]}]
set_driving_cell -lib_cell BUFX8 -library slow_vdd1v2 -pin "Y" [get_ports {B[1]}]
set_driving_cell -lib_cell BUFX8 -library slow_vdd1v2 -pin "Y" [get_ports {B[0]}]
set_driving_cell -lib_cell BUFX8 -library slow_vdd1v2 -pin "Y" [get_ports clk]
set_driving_cell -lib_cell BUFX8 -library slow_vdd1v2 -pin "Y" [get_ports {Opcode[1]}]
set_driving_cell -lib_cell BUFX8 -library slow_vdd1v2 -pin "Y" [get_ports {Opcode[0]}]
set_dont_use true [get_lib_cells slow_vdd1v2/SDFFQX1]
set_dont_use true [get_lib_cells slow_vdd1v2/SDFFQX2]
set_dont_use true [get_lib_cells slow_vdd1v2/SDFFQX4]
set_dont_use true [get_lib_cells slow_vdd1v2/SDFFQXL]
set_clock_uncertainty -setup 0.5 [get_clocks clk]
set_clock_uncertainty -hold 0.5 [get_clocks clk]

