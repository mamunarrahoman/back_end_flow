#########################################################################################################
# Design Name   : alu_4bit                                                                              #
# Designer Name : Mamunar Rahoman                                                                       #
# Tool          : Cadence Innovus & Cadence Genus                                                       #
# Date_of_start :                                                                                       #
# Date_of_End   :                                                                                       #
# #######################################################################################################

# Synthesis with GENUS
syn :
                @genus -file ./scripts/synthesis_script.tcl | tee log/sysnthesis.log
                @touch log/synthesis.pass

init_design :
                @innovus -init ./scripts/init_design.tcl | tee log/init_design.log
                @touch log/init_design.pass
power_design : 
                @innovus -init ./scripts/power.tcl | tee log/power_design.log
                @touch log/power_design.pass

