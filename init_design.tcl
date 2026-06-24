#####################################################################################
# BLOCK NAME    : alu_4bit                                                          #
# TOOL          : INNOVUS | CADENCE                                                 #
# DESIGNER      : MAMUNAR RAHOMAN                                                   #
# VERSION       : 1.0.1                                                             #
# STAGE         : init_design                                                       #
# SCRIPT NAME   : init_design.tcl                                                   #
#####################################################################################

# Initiate design related variable from config file
source -echo ./scripts/config.tcl

# Set some UI related variable
set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799

#Define Power & Ground Net Name
set init_pwr_net $POWER_NET
set init_gnd_net $GROUND_NET
#Initiate the design with necessary variable
set init_lef_file $lef_files
set init_verilog $verilog
set init_mmmc_file $MMMC_PATH
set init_top_cell $top_module_name
#Super command for initiate the design
init_design

# Floorplan
floorPlan -site CoreSite -s 40 15.4 2 2 2 2

# Insert EndCap Cell or Boundary Cell in design.
# As no dedicated ENDCAP cell is defined in the LEF file, the DCAP cell is temporarily employed as the boundary (EndCap) cell for this implementation.

set left_ecap_cell DECAP4; # define cell
set right_ecap_cell DECAP4;
set top_ecap_cell DECAP2;
set bottom_ecap_Cell DECAP2;
# set left_top_corner XXXX;
# set left_bottom_corner XXXX;
# set right_top_corner XXXX;
# set right_bottom_corner XXXX;

setEndCapMode -leftEdge $left_ecap_cell;
setEndCapMode -rightEdge $right_ecap_cell;
setEndCapMode -topEdge $top_ecap_cell;
setEndCapMode -bottomEdge $bottom_ecap_Cell;
# setEndCapMode -leftTopCorner $left_top_corner;
# setEndCapMode -leftBottomCorner $left_bottom_corner;
# setEndCapMode -rightTopCorner $right_top_corner;
# setEndCapMode -rightBottomCorner $right_bottom_corner;

# Super command for inserting ENDCAP cell
addEndCap -prefix end_cap

# Insert Well-Tap Cell
set tap_cell DECAP2; # No Tap cell present in the LEF file, the DCAP cell is temporarily employed as the TAP cell for this implementation.
addWellTap -cell $tap_cell -cellInterval 15 -prefix well_tap -skipRow 1 -inRowOffset 5

# Inserting Routing blockage around the core as DECAP cell placed around the core. To prevent special route extension
createRouteBlk -box 1.99050 16.64750 41.99550 17.49800 -layer {Metal1}
createRouteBlk -box 2.01 2.09 2.78 17.445 -layer {Metal1}
createRouteBlk -box 1.99 2.11 42.03 3.085 -layer {Metal1}
createRouteBlk -box 41.19 2.08 42.04 17.505 -layer {Metal1}

#GNC (Global Net Connect)
globalNetConnect $POWER_NET -type pgpin -pin $SC_POW -inst * -verbose
globalNetConnect $GROUND_NET -type pgpin -pin $SC_GND -inst * -verbose

#Pin assignment [LEFT]
editPin 	-fixedPin 1 \
		-fixOverlap 1 \
		-unit MICRON \
		-spreadDirection clockwise \
		-side Left \
		-layer 3 \
		-spreadType center \
		-spacing 0.2 \
		-pin {{A[0]} {A[1]} {A[2]} {A[3]} {B[0]} {B[1]} {B[2]} {B[3]}}

#Pin assignment [RIGHT]
editPin 	-fixedPin 1 \
		-fixOverlap 1 \
		-unit MICRON \
		-spreadDirection clockwise \
		-side Right \
		-layer 3 \
		-spreadType center \
		-spacing 0.2 \
		-pin {{Y[0]} {Y[1]} {Y[2]} {Y[3]} {Y[4]} {Y[5]} {Y[6]} {Y[7]}}

#Pin assignment [TOP]
editPin 	-fixedPin 1 \
		-fixOverlap 1 \
		-unit MICRON \
		-spreadDirection clockwise \
		-side Top \
		-layer 2 \
		-spreadType center \
		-spacing 1.0 \
		-pin clk

#Pin assignment [BOTTOM]
editPin 	-fixedPin 1 \
		-fixOverlap 1 \
		-unit MICRON \
		-spreadDirection clockwise \
		-side Bottom \
		-layer 1 \
		-spreadType center \
		-spacing 1.0 \
		-pin {{Opcode[0]} {Opcode[1]}}

#save design
saveDesign ./DESIGN/init_design.inn

exit
