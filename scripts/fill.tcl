#########################################################################################################
# Project Name  : alu_4bit                                                                              #
# Project Version: v1.00.1                                                                              #
# Design Stage  : Fill                                                                                  #
# Script Name   : fill.tcl                                                                              #
# Designer Name : Mamunar Rahoman                                                                       #
#########################################################################################################

##Initiate design related variable from config file
source -echo ./scripts/config.tcl
##Restore design from previous stage
restoreDesign ./DESIGN/route_design.inn.dat $top_module_name

# Physical-Only Filler Cell Insertion
set FILLER_CELLS "FILL8 FILL64 FILL4 FILL32 FILL2 FILL16 FILL1 DECAP10"

# Insert filler cells
addFiller \
    -cell $FILLER_CELLS \
    -prefix FILLER

# Verify placement
checkPlace > reports/filler_check.rpt

# Setting for Metal Fill
setMetalFill -maxLength 10

# Add metal fill
addMetalFill

# Verify geometry
verifyGeometry > reports/metal_fill_drc.rpt

# Clear DRC highlight
clearDrc

#Save the design
saveDesign ./DESIGN/fill_design.inn

# Export Design
streamOut gds/alu_4bit.gds.gz \
-mapFile pdk/stdcell/streamOut.map \
-libName DesignLib \
-structureName alu_4bit \
-units 2000 \
-mode ALL \
-uniquifyCellNames \
-merge pdk/stdcell/gsclib045.gds

exit

