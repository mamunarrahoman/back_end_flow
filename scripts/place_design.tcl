#########################################################################################################
# Project Name  : alu_4bit                                                                              #
# Project Version: v1.00.1                                                                              #
# Design Stage  : Placement                                                                             #
# Script Name   : place_design.tcl                                                                      #
# Designer Name : Mamunar Rahoman                                                                       #
#########################################################################################################

##Initiate design related variable from config file
source -echo ./scripts/config.tcl
##Restore design from previous stage
restoreDesign ./DESIGN/power_design.inn.dat $top_module_name

# Placement Settings
setPlaceMode -place_global_cong_effort high
setPlaceMode -place_global_clock_power_driven true
setPlaceMode -place_global_timing_effort high
setPlaceMode -place_detail_wire_length_opt high
setPlaceMode -place_detail_eco_max_distance 10

# Super command for Placement
place_design

# Pre-CTS Optimization
optDesign -preCTS

#Timing Reports
timeDesign -preCTS \
           -pathReports \
           -drvReports \
           -slackReports \
           -numPaths 50 \
           -outDir reports/preCTS

# Congestion report
reportCongestion -overflow > reports/congestion.rpt

# Utilization report
report_density_map > reports/density_map.rpt

#Save the design
saveDesign ./DESIGN/place_design.inn

exit
