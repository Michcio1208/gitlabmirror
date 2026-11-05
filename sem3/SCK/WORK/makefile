
MODEL_FILES = ../MODEL/*.v
SYNTH_FILES = ../SYNTH/*.v
BENCH_FILES = ../BENCH/*.v

SYNTH = yosys
SIMUL = iverilog

sim_model:
	${SIMUL} -g2005-sv ${BENCH_FILES} ${MODEL_FILES}  -o simulate_model.run 
	./simulate_model.run

sim_synth:
	${SIMUL} -g2005-sv ${BENCH_FILES} ${SYNTH_FILES}  -o simulate_synth.run 
	./simulate_synth.run

synth:
	${SYNTH} -s synth.ys |& tee synth.log

waves:
	gtkwave waves.vcd &