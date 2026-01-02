# ==============================================================================
# bist.sdc (Top: bist) — tightened + hold-friendly
# Pure SDC (no remove_from_collection/sizeof_collection/etc.)
# ==============================================================================

# ----------------------------
# Clock (tightened)
# ----------------------------
create_clock -name CORE_CLK -period 6.0 [get_ports clk]

# Uncertainty: apply to setup only (avoid worsening hold)
set_clock_uncertainty -setup 0.20 [get_clocks CORE_CLK]
set_clock_uncertainty -hold  0.00 [get_clocks CORE_CLK]

# ----------------------------
# Input delays
# Use -max for setup, -min for hold (keep hold relaxed)
# ----------------------------
set_input_delay -max 1.0 -clock CORE_CLK [get_ports {start rst csin rwbarin opr}]
set_input_delay -max 1.0 -clock CORE_CLK [get_ports {address[*]}]
set_input_delay -max 1.0 -clock CORE_CLK [get_ports {datain[*]}]

set_input_delay -min 0.0 -clock CORE_CLK [get_ports {start rst csin rwbarin opr}]
set_input_delay -min 0.0 -clock CORE_CLK [get_ports {address[*]}]
set_input_delay -min 0.0 -clock CORE_CLK [get_ports {datain[*]}]

# ----------------------------
# Output delays
# ----------------------------
set_output_delay -max 1.0 -clock CORE_CLK [get_ports {dataout[*]}]
set_output_delay -max 1.0 -clock CORE_CLK [get_ports {fail}]

set_output_delay -min 0.0 -clock CORE_CLK [get_ports {dataout[*]}]
set_output_delay -min 0.0 -clock CORE_CLK [get_ports {fail}]

