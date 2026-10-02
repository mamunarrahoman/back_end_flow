# 4-bit ALU ASIC Physical Design Flow

This repository contains the complete automated RTL-to-GDSII physical design flow for a **4-bit Arithmetic Logic Unit (ALU)** using industry-standard Cadence EDA tools.

## Design Metadata
* **Design Name:** `alu_4bit`
* **Designer:** Mamunar Rahoman
* **Synthesis Tool:** Cadence Genus
* **Physical Design Tool:** Cadence Innovus

---

## ASIC Design Flow Stages

The flow is managed via a comprehensive `Makefile` that automates sequential steps from logical synthesis to physical filling. Each stage checks for tool execution errors and logs output cleanly.

| Stage | Target Name | Tool | Description |
| :--- | :--- | :--- | :--- |
| **1. Synthesis** | `syn` | Cadence Genus | Converts RTL description into a gate-level netlist using technology libraries. |
| **2. Initialization** | `init_design` | Cadence Innovus | Initializes the physical design, imports netlists, and sets up floorplanning. |
| **3. Power Planning** | `power_design` | Cadence Innovus | Builds the power grid (rings, stripes, and rails) for stable power distribution. |
| **4. Placement** | `place_design` | Cadence Innovus | Places standard cells logically within the core area to minimize wirelength and congestion. |
| **5. CTS (Clock Tree Synthesis)** | `ccopt_design` | Cadence Innovus | Synthesizes the clock tree to minimize skew and insertion delay using CCOpt. |
| **6. Routing** | `route_design` | Cadence Innovus | Performs global, track assignment, and detailed routing for signal interconnects. |
| **7. Filling** | `fill` | Cadence Innovus | Inserts metal fill and filler cells to satisfy density rules and manufacturing constraints. |

---

## Directory Structure
```text
.
├── Makefile
├── scripts/
│   ├── synthesis_script.tcl
│   ├── init_design.tcl
│   ├── power.tcl
│   ├── place_design.tcl
│   ├── ccopt_design.tcl
│   ├── route_design.tcl
│   └── fill.tcl
└── log/
    └── *.log & *.pass (Generated during execution)
```

---

## How to Run

You can execute the entire flow sequentially or run individual stages using `make`.

### Run the Full Flow
To run the complete automated sequence from synthesis down to final filling:
```bash
make syn init_design power_design place_design ccopt_design route_design fill
```

### Run Individual Stages
Each stage depends on the successful completion of the preceding one. For example, to run up to placement:
```bash
make place_design
```

### Clean Up Logs
To remove all pass flags and intermediate log verification markers:
```bash
make clean
