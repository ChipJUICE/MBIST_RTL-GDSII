# 💾 MBIST Project – 64×8 SRAM Built-In Self-Test  

## 📘 Overview
This repository contains the complete **Memory Built-In Self-Test (MBIST)** implementation for a **64 × 8-bit single-port SRAM** using **SystemVerilog**.  
The project demonstrates how on-chip self-test logic can detect SRAM faults without relying on external testers.

The design covers **full front-end and back-end implementation**, including:
- RTL development and verification in **Synopsys VCS**
- Modular functional testbenches for each sub-block
- Logic synthesis in **Synopsys Design Compiler** with timing constraints
- Full **RTL → GDSII physical design flow** using **Cadence Innovus**
- Physical implementation using **TSMC 16nm PDK**
- Generation of **DRC-clean and LVS-clean GDSII**

---

## 🏗️ Architecture
The design follows a modular approach.  
The top-level **BIST** module integrates the following blocks:

| Module | Purpose |
| ------ | ------- |
| **Comparator** | Compares expected test pattern (`data_t`) with SRAM output (`ramout`) and sets flags `eq`, `gt`, `lt`. |
| **Counter** | Parameterized synchronous counter for address generation, timing control, and pattern selection. Supports up/down count, load, and carry-out. |
| **Decoder** | Generates 8-bit test patterns (e.g. `10101010`, `01010101`, `11110000`) from a 3-bit selector to detect stuck-at and pattern-sensitivity faults. |
| **Controller (FSM)** | Finite-state machine controlling reset and test phases using `start`, `NbarT`, and `ld` signals. |
| **Multiplexer** | Parameterized mux to switch address/data paths between normal mode and BIST mode. |
| **SRAM** | 64×8 single-port synchronous SRAM model with chip-select (`cs`) and read/write (`rwbar`) support. |
| **BIST (Top)** | Integrates all modules, drives SRAM operation, monitors comparison results, and asserts a `fail` flag. |

---

## ⚙️ Key Features
- Parameterized design (`size`, `length`) for easy scalability
- Single generic multiplexer reused for address and data paths
- Pre-defined on-chip test patterns for fault detection
- Real-time **fail flag** for immediate fault indication
- Synthesizable RTL meeting timing at **6 ns clock period**
- Fully realizable backend implementation

---

## 📂 Repository Structure
```
MBIST/
│
├── MBIST/
│   ├── constraints/
│   │   └── controller.sdc
│   ├── src/
│   │   ├── comparator.sv
│   │   ├── counter.sv
│   │   ├── decoder.sv
│   │   ├── controller.sv
│   │   ├── multiplexer.sv
│   │   ├── sram.sv
│   │   └── bist.sv
│   └── tb/
│       ├── tb_comparator.sv
│       ├── tb_counter.sv
│       ├── tb_decoder.sv
│       ├── tb_controller.sv
│       ├── tb_multiplexer.sv
│       ├── tb_sram.sv
│       └── tb_bist.sv
│
├── Physical_design/
│   ├── constraints/
│   │   └── physical.sdc
│   ├── netlist/
│   │   └── bist_synth.v
│   ├── scripts/
│   │   ├── init_innovus.tcl
│   │   ├── floorplan.tcl
│   │   ├── power_plan.tcl
│   │   ├── place.tcl
│   │   ├── cts.tcl
│   │   └── route.tcl
│   ├── output/
│   │   ├── bist.gds
│   │   ├── bist.def
│   │   ├── timing_reports/
│   │   └── drc_lvs_reports/
│   ├── Layout.png
│   └── schematic.png
│
├── VCS/
│   ├── compiler.log
│   └── simv
│
└── README.md

```

---

## ▶️ Simulation
- **Simulator:** Synopsys VCS  
- Each submodule is verified independently before integrated testing.

```bash
vcs -sverilog src/*.sv tb/tb_bist.sv -o simv
./simv
```

---

## 🛠️ Synthesis
- **Tool:** Synopsys Design Compiler  

```tcl
create_clock -period 6 -name clk [get_ports clk]
set_input_delay 0.1  -clock clk [all_inputs]
set_output_delay 0.15 -clock clk [all_outputs]
set_load 0.1 [all_outputs]
set_max_fanout 1 [all_inputs]
set_fanout_load 8 [all_outputs]
set_clock_uncertainty 0.01 [all_clocks]
set_clock_latency 0.01 -source [get_ports clk]
```

---

## 🧩 Physical Design (RTL → GDSII)

The synthesized MBIST netlist was taken through a **complete digital physical design flow**, validating the design as a manufacturable digital block.

### 🔧 Physical Design Flow
- **Tool:** Cadence Innovus Implementation System
- **Technology:** TSMC 16nm PDK
- **Implementation Style:** Standard-cell only (no SRAM macros)  
- **Floorplan:** Compact **60 µm × 60 µm** core area  
- **Power Planning:** Dedicated VDD/VSS power rings on upper metal layers  
- **Placement:** Timing-driven standard-cell placement  
- **Clocking:** Single propagated clock network  
- **Routing:** Global and detailed routing with DRC-aware settings  

### 🧪 Sign-off Results
- **Timing:** Setup and hold clean (no violations)  
- **DRC:** DRC-clean layout  
- **LVS:** LVS-clean GDSII  
- **Final Output:** Manufacturable **GDSII generated successfully**

---

## ✅ Results
- All submodules passed functional simulation
- Integrated MBIST correctly detected injected SRAM faults
- Timing closure achieved at **6 ns clock period**
- Full **RTL → GDSII flow completed**
- **Zero timing violations**
- **DRC-clean and LVS-clean GDSII**

---

## 🚀 Quick Start
```bash
git clone https://github.com/ChipJUICE/MBIST.git
cd MBIST
```

---

## 👤 Author
**Naveen Kumar Senthil Kumar**  
M.S. Computer Engineering, NYU Tandon  
📧 ns6503@nyu.edu
