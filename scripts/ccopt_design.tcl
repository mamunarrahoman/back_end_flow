#########################################################################################################
# Project Name  : alu_4bit                                                                              #
# Project Version: v1.00.1                                                                              #
# Design Stage  : CTS                                                                                   #
# Script Name   : ccopt_design.tcl                                                                      #
# Designer Name : Mamunar Rahoman                                                                       #
#########################################################################################################

##Initiate design related variable from config file
source -echo ./scripts/config.tcl
##Restore design from previous stage
restoreDesign ./DESIGN/place_design.inn.dat $top_module_name

# CTS Configuration
setCTSMode -engine ccopt

# Target skew and transition
set_ccopt_property target_skew 0.05
set_ccopt_property target_max_trans 0.20

# Generate Clock Tree Specification
create_ccopt_clock_tree_spec -file ccopt.spec
source ccopt.spec

# Run Clock Tree Synthesis
ccopt_design -cts

# Post-CTS Optimization
optDesign -postCTS

# Timing Analysis
timeDesign -postCTS \
           -pathReports \
           -drvReports \
           -slackReports \
           -numPaths 50 \
           -outDir reports/postCTS

# Clock Tree Reports
report_ccopt_clock_trees \
    -file reports/clock_trees.rpt

report_ccopt_skew_groups \
    -file reports/skew_groups.rpt

#Save the design
saveDesign ./DESIGN/ccopt_design.inn

exit
