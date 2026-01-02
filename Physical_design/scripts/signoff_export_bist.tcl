# =========================================================
# signoff_export_bist.tcl – final exports (DEF/GDS)
# =========================================================

file mkdir ./results

# Final database snapshot
saveDesign ./results/bist_final.enc

# Final checks (lightweight)
verifyConnectivity -type all -report ./results/verify_connectivity.rpt

# Stream out GDS
# IMPORTANT: Update -mapFile to your real PDK stream map file.
streamOut ./results/bist_final.gds \
  -mapFile ./gds/streamOut.map \
  -libName WORK \
  -topCell bist \
  -units 1000 \
  -mode ALL

puts "INFO: Wrote GDS to ./results/bist_final.gds"

