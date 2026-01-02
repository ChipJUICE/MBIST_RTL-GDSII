# =========================================================
# place_bist.tcl – placement
# =========================================================

file mkdir ./results

setPlaceMode -congEffort high
setPlaceMode -timingDriven true

checkDesign -all > ./results/check_design_pre_place.rpt

place_opt_design

saveDesign ./results/bist_placed.enc

report_timing -max_paths 20 > ./results/timing_post_place.rpt

redirect ./results/congestion_post_place.rpt {
  reportCongestion -hotSpot -overflow
}

