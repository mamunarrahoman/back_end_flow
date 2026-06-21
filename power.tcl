#########################################################################################################
# Project Name  : alu_4bit                                                                              #
# Project Version: v1.00.1                                                                              #
# Design Stage  : POWER PLANNING                                                                        #
# Script Name   : power.tcl                                                                             #
# Designer Name : Mamunar Rahoman                                                                       #
#########################################################################################################

#Initiate design related variable from config file
source -echo ./scripts/config.tcl
#Restore design from previous stage
restoreDesign ./DESIGN/init_design.inn.dat $top_module_name

#Extra port creation according to requirement
set enable_power_port 1

#Define Metal layer for Power-Planning
set top_power_net_layer 5
set bottom_power_net_layer 4
set layer_width 0.1
set layer_spacing 0.1

#set condition for symmetrical offset
set offset 2

#Super command for adding power strip in design. [Power mesh configuration]
for {set i $top_power_net_layer} {$i>=$bottom_power_net_layer} {incr i -1} {
if {$i%2==0} {
                set direction vertical
                set number_of_strip 16
                set start_point [expr [dbget head.topCells.fplan.coreBox_llx]+$offset]
                set end_point [expr [dbget head.topCells.fplan.coreBox_urx]-$offset]
        } else {
                set direction horizontal
                set number_of_strip 6
                set start_point [expr [dbget head.topCells.fplan.coreBox_lly]+$offset]
                set end_point [expr [dbget head.topCells.fplan.coreBox_ury]-$offset]
}
addStripe       -nets "$POWER_NET $GROUND_NET" \
                -layer "Metal$i" \
                -direction $direction \
                -width $layer_width \
                -spacing $layer_spacing \
                -number_of_sets $number_of_strip \
                -extend_to design_boundary \
                -create_pins $enable_power_port \
                -start_from bottom \
                -start $start_point \
                -stop $end_point \
                -switch_layer_over_obs false \
                -max_same_layer_jog_length 2 \
                -padcore_ring_top_layer_limit $top_power_net_layer \
                -padcore_ring_bottom_layer_limit $bottom_power_net_layer \
                -block_ring_top_layer_limit $top_power_net_layer \
                -block_ring_bottom_layer_limit $bottom_power_net_layer \
                -use_wire_group 0 \
                -snap_wire_center_to_grid None
}

#Create power-ground rail by special route
sroute          -connect { blockPin padPin padRing corePin floatingStripe } \
                -layerChangeRange "Metal1(1) Metal$bottom_power_net_layer\($bottom_power_net_layer)" \
                -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } \
                -padPinTarget { nearestTarget } \
                -corePinTarget { firstAfterRowEnd } \
                -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } \
                -allowJogging 0 \
                -crossoverViaLayerRange { Metal1(1) Metal11(11) } \
                -nets "$POWER_NET $GROUND_NET" \
                -allowLayerChange 0 \
                -blockPin useLef \
                -targetViaLayerRange { Metal1(1) Metal11(11) }
clearDrc

#Save the design
saveDesign ./DESIGN/power_design.inn

exit

