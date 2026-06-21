#####################################################################################
# BLOCK NAME    : alu_4bit                                                          #
# TOOL          : INNOVUS | CADENCE                                                 #
# DESIGNER      : MAMUNAR RAHOMAN                                                   #
# VERSION       : 1.0.0                                                             #
# STAGE         : RTL Synthesis                                                     #
# SCRIPT NAME   : synthesis.tcl                                                     #
#####################################################################################

set_db init_lib_search_path     "pdk/stdcell"
set_db library                  "slow_vdd1v2_basicCells.lib"
set_db lef_library              "pdk/stdcell/gsclib045_tech.lef pdk/stdcell/gsclib045_macro.lef"
set_db hdl_search_path input_files

read_hdl alu_4bit.v
elaborate

set_top_module alu_4bit
current_design alu_4bit
write_hdl > ./syn_export/alu_4bit_elaborated.v

############### constraints ###############
create_clock -name clk -period 10 [get_ports clk]
set_clock_uncertainty -setup 0.5 [get_clocks clk]
set_clock_uncertainty -hold 0.5 [get_clocks clk]
set_max_transition 2 [get_ports clk]
set_clock_transition -min -fall 0.5 [get_clocks clk]
set_clock_transition -min -rise 0.5 [get_clocks clk]
set_clock_transition -max -fall 0.5 [get_clocks clk]
set_clock_transition -max -rise 0.5 [get_clocks clk]
set_clock_groups -name original -group [list [get_clocks clk]]
set DRIVING_CELL BUFX8
set DRIVE_PIN {Y}
set_driving_cell -lib_cell $DRIVING_CELL -pin $DRIVE_PIN [all_inputs]
set_max_fanout 10 [current_design]
set_load 0.5 [all_outputs]
set_operating_conditions PVT_1P08V_125C
set_input_delay -max 0.5 [all_inputs]
set_output_delay -max 0.5 [all_outputs]
set_dont_use SDFFQX*
###########################################

remove_assign -buffer_or_inverter BUFX16 -design [current_design]
syn_gen
write_hdl > ./syn_export/alu_4bit_generic.v
syn_map
write_hdl > ./syn_export/alu_4bit_post_synthesis.v
set_remove_assign_options -buffer_or_inverter BUFX12 -verbose
remove_assigns_without_opt -buffer_or_inverter BUFX12 -verbose
syn_opt
write -mapped > ./syn_export/alu_4bit_mapped.v
write_sdc > ./syn_export/alu_4bit.sdc
exit

