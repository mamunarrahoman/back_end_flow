##########################################################################################################
# Project Name   : alu_4bit                                                                              #
# Project Version: v1.00.1                                                                               #
# Design Stage   : Design Variable configuration                                                         #
# Script Name    : config.tcl                                                                            #
# Designer Name  : Mamunar Rahoman                                                                       #
##########################################################################################################

# Specify necessary variable
set top_module_name     "alu_4bit"
set POWER_NET           "VDD"
set GROUND_NET          "VSS"
set SC_POW              "VDD"
set SC_GND              "VSS"
set verilog             "./syn_export/alu_4bit_mapped.v"
set MMMC_PATH           "./scripts/mmmc.tcl"
set lef_files           {pdk/stdcell/gsclib045_tech.lef\
                         pdk/stdcell/gsclib045_macro.lef}
