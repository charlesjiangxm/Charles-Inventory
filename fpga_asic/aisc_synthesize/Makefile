##################################################
# Makefile for the behavior simulation of LRAHash
##################################################

VCS_BIN:=vcs -full64
VCS_OPTION:=+v2k -debug_all
TOP_MODULE:=AcceleratorTestbench
FLIST:=/home/jingyang/research/LRAHash/flist/accelerator.flist
TIME_SCALE:=1ns/10ps
SEARCH_PATH:=/home/jingyang/research/LRAHash/rtl
MEM_LIB_PATH:=/home/jingyang/research/LRAHash/mem
CACTI_MEM_LIB:=$(MEM_LIB_PATH)/SRAM_16x65536_1P/SRAM_16x65536_1P.v

run:
	$(VCS_BIN) $(VCS_OPTION) -f $(FLIST) -timescale=$(TIME_SCALE) \
		+incdir+$(SEARCH_PATH) -v $(CACTI_MEM_LIB) -top $(TOP_MODULE)

.PHONY: clean

clean:
	rm -fr csrc simv simv.daidir
	rm -fr DVE* ucli* *.vpd
