#########################################################################################################
# Project Name  : alu_4bit                                                                              #
# Project Version: v1.00.1                                                                              #
# Design Stage  : Route                                                                                 #
# Script Name   : route_design.tcl                                                                      #
# Designer Name : Mamunar Rahoman                                                                       #
#########################################################################################################

##Initiate design related variable from config file
source -echo ./scripts/config.tcl
##Restore design from previous stage
restoreDesign ./DESIGN/ccopt_design.inn.dat $top_module_name

# NanoRoute Options
setNanoRouteMode -routeWithTimingDriven true
setNanoRouteMode -routeWithSiDriven true
setNanoRouteMode -drouteUseMultiCutViaEffort high

# Detailed Routing
routeDesign

# Analysis Mode set-up
setAnalysisMode -analysisType onChipVariation

# Post-Route Optimization
optDesign -postRoute -setup
optDesign -postRoute -hold

# Timing Analysis
timeDesign -postRoute \
           -pathReports \
           -drvReports \
           -slackReports \
           -numPaths 50 \
           -outDir reports/postRoute

timeDesign -postRoute -hold \
           -pathReports \
           -slackReports \
           -numPaths 50 \
           -outDir reports/postRoute_hold

# DRC Verification
verify_drc > reports/drc.rpt

# Connectivity Check
verifyConnectivity > reports/connectivity.rpt

#Save the design
saveDesign ./DESIGN/route_design.inn

exit


