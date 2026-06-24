#####################################################################################
# BLOCK NAME    : alu_4bit                                                          #
# TOOL          : INNOVUS | CADENCE                                                 #
# DESIGNER      : MAMUNAR RAHOMAN                                                   #
# VERSION       : 1.0.0                                                             #
# STAGE         : Multi Mode Multi Corner Configuration                             #
# SCRIPT NAME   : mmmc.tcl                                                          #
#####################################################################################

create_rc_corner -name qrc -preRoute_res {1.0} -preRoute_cap {1.0} -preRoute_clkres {0.0} -preRoute_clkcap {0.0} -postRoute_res {1.0} -postRoute_cap {1.0} -postRoute_xcap {1.0} -postRoute_clkres {0.0} -postRoute_clkcap {0.0} -qx_tech_file {pdk/stdcell/gpdk045.tch}
create_library_set -name max_timing -timing {pdk/stdcell/slow_vdd1v2_basicCells.lib}
create_library_set -name min_timing -timing {pdk/stdcell/fast_vdd1v2_basicCells.lib}
create_constraint_mode -name functional_sdc -sdc_files {./syn_export/alu_4bit.sdc}
create_delay_corner -name max_delay -library_set {max_timing} -rc_corner {qrc}
create_delay_corner -name min_delay -library_set {min_timing} -rc_corner {qrc}
create_analysis_view -name func_slow -constraint_mode {functional_sdc} -delay_corner {max_delay}
create_analysis_view -name func_fast -constraint_mode {functional_sdc} -delay_corner {min_delay}
set_analysis_view -setup {func_slow} -hold {func_fast}
