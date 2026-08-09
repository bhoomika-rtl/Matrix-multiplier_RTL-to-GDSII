set_db lib_search_path /"<path-to-library-specific-to-your-technology>"
set_db library typical.lib
set_db hdl_search_path ./rtl

read_hdl matrix_cont.v
read_hdl matrix_datapath.v
read_hdl multi_top.v

elaborate multi_top

check_design

read_sdc matrix_32.sdc

syn_gen
syn_map
syn_opt

check_timing

write_hdl > matrix_32_netlist.v
write_sdc > matrix_32_out.sdc
write_sdf \
-timescale ns \
-nonegchecks \
-recrem split \
-edges check_edge \
> matrix_32.sdf

report timing > timing.rep
report area > area.rep
report power > power.rep
report qor > qor.rep
report messages > messages.rep

gui_show