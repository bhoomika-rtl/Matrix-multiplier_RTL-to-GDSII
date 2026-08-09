set init_mmmc_version 2

set init_lef_file {
    /"<technology-specific-lef-file-path>"
    /"<macro-lef-path>"
}

set init_verilog "<netlist_file-generated-by-genus>"

set init_top_cell "multi_top"
set init_design_settop 1

set init_lib_search_path "<liberty-file-path>"
set init_lib_file "typical.lib"

set init_mmmc_file "<multi-mode-multi-corner file path>"

init_design

floorPlan \
-site gsclib090site \
-r 1.0 \
0.55 \
15 15 15 15

globalNetConnect VDD -type pgpin -pin VDD -all
globalNetConnect VSS -type pgpin -pin VSS -all

addRing \
-nets {VDD VSS} \
-type core_rings \
-follow core \
-layer {top Metal9 bottom Metal9 left Metal8 right Metal8} \
-width 1 \
-spacing 1

addStripe \
-nets {VDD VSS} \
-layer Metal9 \
-direction vertical \
-width 1 \
-spacing 1 \
-set_to_set_distance 60

sroute

addEndCap \
-preCap FILL64 \
-postCap FILL64

addWellTap \
-cell FILL1 \
-cellInterval 50

setPlaceMode -timingDriven true
setPlaceMode -congEffort high

placeDesign

reportCongestion > congestion_preCTS.rpt

optDesign -preCTS

create_ccopt_clock_tree_spec -file ccopt.spec

set_ccopt_property buffer_cells {
CLKBUFX2
CLKBUFX3
CLKBUFX4
CLKBUFX6
CLKBUFX8
CLKBUFX12
CLKBUFX16
CLKBUFX20
}

set_ccopt_property inverter_cells {
CLKINVX2
CLKINVX3
CLKINVX4
CLKINVX6
CLKINVX8
CLKINVX12
CLKINVX16
CLKINVX20
}

ccopt_design

optDesign -postCTS
routeDesign
optDesign -postRoute

addFiller \
-cell {FILL64 FILL32 FILL16 FILL8 FILL4 FILL2 FILL1}

verifyConnectivity
verifyGeometry

timeDesign -postRoute

report_timing > matrix3x3_timing.rpt
report_power > matrix3x3_power.rpt
report_area > matrix3x3_area.rpt
reportCongestion > congestion_postroute.rpt
report_qor > qor.rpt

saveDesign matrix3x3.enc

streamOut matrix3x3.gds \
-mapFile streamOut.map \
-libName matrix3x3 \
-units 1000 \
-mode ALL

write_sdf matrix3x3_postroute.sdf
write_verilog matrix3x3_postroute.v