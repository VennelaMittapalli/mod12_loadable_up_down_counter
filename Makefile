# Makefile for Memory - Regression Testing - Lab10

# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS

SIMULATOR = Questa
FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64
RTL= ../rtl/*.v
work= work #library name
SVTB1= ../env_lib/count_if.sv
INC = +incdir+../env +incdir+../env_lib +incdir+../test
SVTB2 = ../test/count_pkg.sv  ../test/top.sv
COVOP = -coveropt 3 +cover=bcft
VSIMOPT= -vopt -voptargs=+acc
VSIMCOV= -coverage -sva
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"

help:
        @echo ===========================================================================================================
        @echo " USAGE           --  make target                                                                                 "
        @echo " clean           =>  clean the earlier log and intermediate files.                                               "
        @echo " sv_cmp          =>  Create library and compile the code.                                                        "                             
        @echo " TC1             =>  To compile and run the testcase1 in batch mode.                                             "
        @echo " TC2             =>  To compile and run the testcase2 in batch mode.                                             "
        @echo " TC3             =>  To compile and run the testcase3 in batch mode.                                             "                             
        @echo " regress_12      =>  clean, compile and run testcases TC1 and TC2 in batch mode.                                 "
        @echo " report_12    =>  To merge coverage reports for testcases TC1, TC2 and  convert to html format.                  "
        @echo " regress_123  =>  clean, compile and run testcases TC1,TC2,TC3 in batch mode.                                    "
        @echo " report_123   =>  To merge coverage reports for testcases TC1,TC2,TC3 and convert to html format.                "
        @echo " covhtml         =>  To view the coverage report in firefox.                                                                     "
        @echo " covtxt       => To view the coverage report in text editor [only for VCS]                                       "
        @echo "cov_verdi        => To view the coverage report in verdi [only for VCS]          "
        @echo ===========================================================================================================

clean : clean_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)
TC1 : TC1_$(SIMULATOR)
TC2 : TC2_$(SIMULATOR)
TC3 : TC3_$(SIMULATOR)
regress_12 : regress_12_$(SIMULATOR)
report_12 : report_12_$(SIMULATOR)
regress_123 : regress_123_$(SIMULATOR)
view_wave : view_wave_$(SIMULATOR)
covhtml : covhtml_$(SIMULATOR)
covtxt: covtxt_$(SIMULATOR)
cov_verdi: cov_verdi_$(SIMULATOR)

# ---- Start of Definitions for Mentor's Questa Specific Targets -----#

sv_cmp_Questa:
        vlib $(work)
        vmap work $(work)
        vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1) $(COVOP)

TC1_Questa:sv_cmp_Questa
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed 2975249645 work.top +TEST1
        vcover report  -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

TC2_Questa:sv_cmp_Questa
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log  -sv_seed 1556525292 work.top +TEST2
        vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2

TC3_Questa:sv_cmp_Questa
                                      
                                                
