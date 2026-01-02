# =========================================================
# cts_bist.tcl – Clock Tree Synthesis
# =========================================================

set_ccopt_property buffer_cells   { CKBD1BWP16P90 CKBD2BWP16P90 CKBD4BWP16P90 CKBD8BWP16P90 }
set_ccopt_property inverter_cells { CKND1BWP16P90 CKND2BWP16P90 CKND4BWP16P90 CKND8BWP16P90 }
set_ccopt_property clock_gating_cells { CKLNQD1BWP16P90 CKLNQD2BWP16P90 CKLNQD4BWP16P90 }

clock_opt_design -cts

saveDesign ./results/bist_postcts.enc

report_timing -max_paths 20 > ./results/timing_post_cts.rpt

