# =========================================================
# power_plan_bist.tcl – basic core power ring (no macros)
# =========================================================

# Core rings
addRing \
  -type core_rings \
  -around default_power_domain \
  -nets {VDD VSS} \
  -layer   {top M7 bottom M7 left M6 right M6} \
  -width   {top 2 bottom 2 left 2 right 2} \
  -spacing {top 2 bottom 2 left 2 right 2} \
  -offset  {top 3 bottom 3 left 3 right 3}

# Optional: connect stdcell rails (usually ok with defaults, but safe)
sroute -connect {corePin} -nets {VDD VSS}

