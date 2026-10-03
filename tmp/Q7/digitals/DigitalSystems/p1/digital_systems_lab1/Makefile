#############################################
# Basic makefile for a vhdl project
# using tang nano 9k board and vhdl
#  _   _ ____   ____           _       
# | | | |  _ \ / ___|  ___  __| |_   _ 
# | | | | |_) | |     / _ \/ _` | | | |
# | |_| |  __/| |___ |  __/ (_| | |_| |
#  \___/|_|    \____(_)___|\__,_|\__,_|                                                                        
#                    
# Albert Comerma
# v0.1 July 2024
# v0.2 Sept 2025 - Modified for tang nano 9k
# v0.3 Nov 2025 - Added windows detection
#############################################

DEVICE=GW1NR-LV9QN88PC6/I5
BOARD=tangnano9k
PROJECT = top
TESTBENCH = top_tb.vhd
SRC_FILES = $(filter-out $(TESTBENCH), $(wildcard *.vhd))

TOP ?= ${PROJECT}
TOP_MODULE ?= ${TOP}
TOP_VHDL ?= ${TOP}.vhd
TB_ENTITY = tb

PNR_DEBUG ?= # --verbose --debug

BOARD ?= UNKNOWN
JTAG_LINK ?= --board ${BOARD}

#Analyze syntax with ghdl
.PHONY: compile
compile: 
	ghdl -a --std=08 $(SRC_FILES)

#Elaborate design with ghdl
.PHONY: elab
elab:
	ghdl -e --std=08 top

#Analyze, elaborate and run testbench
.PHONY: tests
tests: 
	ghdl -a --std=08 $(SRC_FILES)
	ghdl -a --std=08 $(TESTBENCH)
	ghdl -e --std=08 $(TB_ENTITY)
	- ghdl -r --std=08 $(TB_ENTITY)

#Run testbench in gui mode 
.PHONY: tests_gui
tests_gui: 
	ghdl -a --std=08 $(SRC_FILES)
	ghdl -a --std=08 $(TESTBENCH)
	ghdl -e --std=08 $(TB_ENTITY)
	- ghdl -r --std=08 $(TB_ENTITY) --wave=sim.ghw
	gtkwave sim.ghw

#Everything 
.PHONY: all
all: compile elab syn bit

#Program board from command line after building
.PHONY: program
program: 
	openFPGALoader ${JTAG_LINK} --bitstream ${PROJECT}.fs

#Program board and save it to flash
flash: 
	openFPGALoader ${JTAG_LINK} -f --bitstream ${PROJECT}.fs

syn: 
	ghdl -a --std=08 $(SRC_FILES)
ifeq ($(OS),Windows_NT)
	@echo "Windows detected, generating verilog first"
	ghdl synth --std=08 --out=verilog top > top.v
	yosys -p "read_verilog top.v; synth_gowin  -json ${PROJECT}.json"
else
	@echo "Linux or MacOS detected running with ghdl plugin"
	yosys -m ghdl -p "ghdl --std=08 ${TOP_MODULE}; synth_gowin  -json ${PROJECT}.json"
endif
	nextpnr-himbaechel --json ${PROJECT}.json --write ${PROJECT}.pnr.json --device ${DEVICE} --vopt family=GW1N-9C --vopt cst=${BOARD}.cst --freq 27

bit: 
	gowin_pack -d GW1N-9C -o ${PROJECT}.fs ${PROJECT}.pnr.json 

.PHONY: clean
clean:
ifeq ($(OS),Windows_NT)
	@del -f *.fs
	@del -f *.o
	@del -f *.pnr.json
	@del -f *.json
	@del -f *.cf
	@del -f *.v
	@del -f *.exe
	@del -f *.ghw
	@del -f ${PROJECT}
	@del -f ${TB_ENTITY}
else
	@rm -f *.exe
	@rm -f *.fs
	@rm -f *.o
	@rm -f *.pnr.json
	@rm -f *.json
	@rm -f *.cf
	@rm -f *.v
	@rm -f *.ghw
	@rm -f ${PROJECT}
	@rm -f ${TB_ENTITY}
endif