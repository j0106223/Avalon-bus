run_simulation:tb.vvp
	vvp tb.vvp
tb.vvp:start_tb.v ../start_logic.v ../stop_logic.v ../start_stop_logic.v
	iverilog start_tb.v ../start_logic.v ../stop_logic.v ../start_stop_logic.v -o tb.vvp
.PHONY:wave clean
wave:run_simulation
	gtkwave start.vcd
clean:
	rm start.vcd tb.vvp