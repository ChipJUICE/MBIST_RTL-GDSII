# =========================================================
# run_innovus_bist.tcl – RTL(netlist) to GDS flow (no SRAM macros)
# Design  : bist
# Node    : TSMC 16 ADFP
# =========================================================

set DESIGN_NAME  "bist"

# -------- Inputs --------
set NETLIST      "./netlist/synth/bist_netlist.v"
set SDC_FILE     "./constraints/bist.sdc"

# LEF / tech LEF (NO SRAM lef)
set LEF_FILES {
  ./lef/N16ADFP_APR_Innovus_11M.10a.tlef
  ./lef/N16ADFP_StdCell.lef
  ./lef/N16ADFP_BondPad.lef
}

# MMMC file (provided below)
set MMMC_FILE    "./scripts/mmmc_bist.tcl"

# GDS stream-out settings (UPDATE THESE PATHS FOR YOUR PDK)
set GDS_OUT      "./results/bist_final.gds"
set GDS_MAP      "./gds/streamOut.map"     ;# <-- set to your PDK map file
set TOP_CELL     $DESIGN_NAME

# -------- Init --------
set init_design_netlisttype "verilog"
set init_top_cell           $TOP_CELL
set init_verilog            $NETLIST
set init_lef_file           $LEF_FILES
set init_mmmc_file          $MMMC_FILE
set init_sdc_file           $SDC_FILE

# Power/Ground
set init_pwr_net {VDD}
set init_gnd_net {VSS}
set init_design_settop 1

file mkdir ./results

init_design

# -------- Flow steps --------
source ./scripts/floorplan_bist.tcl
source ./scripts/power_plan_bist.tcl
source ./scripts/place_bist.tcl
source ./scripts/cts_bist.tcl
source ./scripts/route_bist.tcl
source ./scripts/signoff_export_bist.tcl

puts "\nINFO: Flow complete. Outputs are in ./results\n"
exit

