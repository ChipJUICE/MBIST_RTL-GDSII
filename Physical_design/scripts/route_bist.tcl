# =========================================================
# route_bist.tcl – route + postroute opt
# =========================================================

file mkdir ./results

setNanoRouteMode -route_with_timing_driven true
setNanoRouteMode -route_with_si_driven      false
setNanoRouteMode -route_detail_search_and_repair true
setNanoRouteMode -route_detail_end_iteration 30
setNanoRouteMode -route_detail_signoff_effort high
# ---- Disable SI-driven AAE-SI optimization (requires OCV) ----
setAnalysisMode -analysisType onChipVariation -off

# Also keep SI off for routing/opt (safe baseline)
setNanoRouteMode -route_with_si_driven false
setOptMode -usefulSkew false

routeDesign -globalDetail -viaOpt -wireOpt

optDesign -postRoute

verify_drc -report ./results/verify_drc_post_route.rpt

saveDesign ./results/bist_routed.enc

report_timing -max_paths 20 > ./results/timing_post_route.rpt
report_area                  > ./results/area_post_route.rpt

defOut -floorplan -netlist -routing ./results/bist_postroute.def
saveNetlist ./results/bist_postroute.v








# Non-OCV baseline
setAnalysisMode -analysisType single
setNanoRouteMode -route_with_si_driven false

# Route
routeDesign -globalDetail -viaOpt -wireOpt

# ❌ NO optDesign
setAnalysisMode -analysisType onChipVariation


optDesign -incr
# or
optDesign -postRoute


