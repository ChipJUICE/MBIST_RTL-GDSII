# =====================================================
# MMMC for bist – REQUIRED for CTS
# =====================================================

# ---- Timing library (MUST EXIST) ----
set LIB_SS "./lib/N16ADFP_StdCelltt0p8v25c.lib"

create_library_set -name LS_SS \
  -timing [list $LIB_SS]

# ---- Delay corner (MANDATORY) ----
create_delay_corner -name DC_SS \
  -library_set LS_SS

# ---- Constraints ----
create_constraint_mode -name CM_FUNC \
  -sdc_files [list ./constraints/bist.sdc]

# ---- Analysis view ----
create_analysis_view -name VIEW_SS \
  -constraint_mode CM_FUNC \
  -delay_corner DC_SS

set_analysis_view -setup VIEW_SS -hold VIEW_SS

