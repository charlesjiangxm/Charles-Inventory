#!/bin/tcsh -f

# file: tcshell script for running behavior simulation using vcs (recommend to use ver.2018)
# create: Oct/15/2021 j84200486
# notice: please ma vcs and ma verdi in your terminal before running this script.

# set environment for including the common Libraries
set SRC_ROOT = "/home/rtl"

if ($* == "vcs") then
    # This command runs the simulation and output the simv file for debugging or dumping the wave
    # -y: Specify the library.
    # +libext: Used together with -y to specify the file extension that will be regarded as library files.
    # -f: Specify the filelist containing your design files
    vcs -full64 \
    -f filelist_design.f \
    -y $AIC_ROOT/dff \
    +libext+.v \
    +libext+.vh \
    +v2k \
    -vcs+lic+wait \
    -l vcs.log \
    -debug_access+all \
    -fsdb \
    -timescale=1ns/1ps \
    tb_single_aic_cube_mnk_decode_l300.v
else if ($* == "simv") then
    # This command runs the simulation until the $finish is reached and dump the wave into the .fsdb file.
    ./simv \
    +vcs+lic+wait \
    -l simv.log \
    +fsdb+autoflush
else if ($* == "verdi") then
    # This command loads the design (.v, for viewing the circuit block) and the waveform (.fsdb) into the Verdi.
    # The parameters are the same as vcs command
    verdi -sv \
    -f filelist_design.f \
    -y $AIC_ROOT/dff \
    +libext+.v \
    +libext+.vh \
    +v2k \
    -vcs+lic+wait \
    -ssf dut.fsdb \
    -nologo \
    tb_single_aic_cube_mnk_decode_l300.v
else
    echo "error: please specify either 'vcs', 'simv' or 'verdi' as the input"
endif
