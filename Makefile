#########################################################################################################
# Design Name	: alu_4bit										#
# Designer Name	: Mamunar Rahoman									#
# Tool		: Cadence Innovus & Cadence Genus							#
# Date_of_start	:											#
# Date_of_End	:										       	#
# #######################################################################################################

.PHONY: syn init_design power_design place_design ccopt_design route_design fill clean

syn: log/synthesis.pass
	@echo "Synthesis Complete"

log/synthesis.pass:
	@echo "Running Synthesis..."
	@genus -file ./scripts/synthesis_script.tcl | tee log/synthesis.log
	@if ! grep "ERROR" log/synthesis.log > /dev/null; then \
		touch log/synthesis.pass; \
		echo "Synthesis PASS"; \
	else \
		echo "Synthesis FAILED"; \
		exit 1; \
	fi

init_design: log/init_design.pass
	@echo "Design has successfully initiated"

log/init_design.pass: log/synthesis.pass
	@echo "Running Init Design..."
	@innovus -init ./scripts/init_design.tcl | tee log/init_design.log
	@if ! grep "ERROR" log/init_design.log > /dev/null; then \
		touch log/init_design.pass; \
		echo "Init Design PASS"; \
	else \
		echo "Init Design FAILED"; \
		exit 1; \
	fi

power_design: log/power_design.pass
	@echo "Power-planning Complete"

log/power_design.pass: log/init_design.pass
	@echo "Running Power Planning..."
	@innovus -init ./scripts/power.tcl | tee log/power_design.log
	@if ! grep "ERROR" log/power_design.log > /dev/null; then \
		touch log/power_design.pass; \
		echo "Power Planning PASS"; \
	else \
		echo "Power Planning FAILED"; \
		exit 1; \
	fi

place_design: log/place_design.pass
	@echo "Placement Complete"

log/place_design.pass: log/power_design.pass
	@echo "Running Placement..."
	@innovus -init ./scripts/place_design.tcl | tee log/place_design.log
	@if ! grep "ERROR" log/place_design.log > /dev/null; then \
		touch log/place_design.pass; \
		echo "Placement PASS"; \
	else \
		echo "Placement FAILED"; \
		exit 1; \
	fi

ccopt_design: log/ccopt_design.pass
	@echo "CTS Complete"

log/ccopt_design.pass: log/place_design.pass
	@echo "Running CTS..."
	@innovus -init ./scripts/ccopt_design.tcl | tee log/ccopt_design.log
	@if ! grep "ERROR" log/ccopt_design.log > /dev/null; then \
		touch log/ccopt_design.pass; \
		echo "CTS PASS"; \
	else \
		echo "CTS FAILED"; \
		exit 1; \
	fi

route_design: log/route_design.pass
	@echo "Routing Complete"

log/route_design.pass: log/ccopt_design.pass
	@echo "Running Routing..."
	@innovus -init ./scripts/route_design.tcl | tee log/route_design.log
	@if ! grep "ERROR" log/route_design.log > /dev/null; then \
		touch log/route_design.pass; \
		echo "Routing PASS"; \
	else \
		echo "Routing FAILED"; \
		exit 1; \
	fi

fill: log/fill_design.pass
	@echo "Filling Complete"

log/fill_design.pass: log/route_design.pass
	@echo "Filling Routing..."
	@innovus -init ./scripts/fill.tcl | tee log/fill_design.log
	@if ! grep "ERROR" log/fill_design.log > /dev/null; then \
		touch log/fill_design.pass; \
		echo "Filling PASS"; \
	else \
		echo "Filling FAILED"; \
		exit 1; \
	fi

clean:
	rm -f log/*.pass
