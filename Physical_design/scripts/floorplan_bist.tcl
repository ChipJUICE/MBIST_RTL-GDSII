# =========================================================
# floorplan_bist.tcl – small core floorplan for bist
# =========================================================

# Area report total cell area ~907 um^2.
# Target utilization ~0.55–0.65 -> core area ~1400–1650 um^2.
# sqrt(1600) ~ 40um, but we oversize for rings/routing.

set CORE_W   60.0
set CORE_H   60.0

set MARGIN_L 10.0
set MARGIN_B 10.0
set MARGIN_R 10.0
set MARGIN_T 10.0

set SITE_NAME "core"
setFPlanMode -defaultTechSite $SITE_NAME

floorPlan -site $SITE_NAME -s $CORE_W $CORE_H $MARGIN_L $MARGIN_B $MARGIN_R $MARGIN_T

file mkdir ./results
redirect ./results/floorplan.rpt { reportFloorplan }

