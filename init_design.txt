#####################################################################################
# BLOCK NAME    : alu_4bit                                                          #
# TOOL          : INNOVUS | CADENCE                                                 #
# DESIGNER      : MAMUNAR RAHOMAN                                                   #
# VERSION       : 1.0.0                                                             #
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
floorPlan -site CoreSite -s 100 30 2 2 2 2



#GNC (Global Net Connect)
globalNetConnect $POWER_NET -type pgpin -pin $SC_POW -inst * -verbose
globalNetConnect $GROUND_NET -type pgpin -pin $SC_GND -inst * -verbose

#Pin assignment [LEFT]
editPin         -fixedPin 1 \
                -fixOverlap 1 \
                -unit MICRON \
                -spreadDirection clockwise \
                -side Left \
                -layer 3 \
                -spreadType center \
                -spacing 0.2 \
                -pin {{A[0]} {A[1]} {A[2]} {A[3]} {B[0]} {B[1]} {B[2]} {B[3]}}

#Pin assignment [RIGHT]
editPin         -fixedPin 1 \
                -fixOverlap 1 \
                -unit MICRON \
                -spreadDirection clockwise \
                -side Right \
                -layer 3 \
                -spreadType center \
                -spacing 0.2 \
                -pin {{Y[0]} {Y[1]} {Y[2]} {Y[3]} {Y[4]} {Y[5]} {Y[6]} {Y[7]}}

#Pin assignment [TOP]
editPin         -fixedPin 1 \
                -fixOverlap 1 \
                -unit MICRON \
                -spreadDirection clockwise \
                -side Top \
                -layer 2 \
                -spreadType center \
                -spacing 1.0 \
                -pin clk

#Pin assignment [BOTTOM]
editPin         -fixedPin 1 \
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

