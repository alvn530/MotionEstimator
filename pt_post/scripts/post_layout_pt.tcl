###### Post Layout PrimeTime Script #######

## Define the library location
source /Users/students/dennison/asic_flow_setup_orig/lib_gen/lib_container.tcl
##set link_library   saed32lvt_ss0p7v125c.db 

##set target_library  saed32lvt_ss0p7v125c.db 

## read the extracted verilog netlist file
read_verilog ../pnr/pnr_ME/output/ME_extracted.v

## Set top module name
current_design top

##Read extracted parasitics
read_parasitics -format SPEF ../pnr/pnr_ME/output/ME_extracted.spef.max

read_parasitics -format SPEF ../pnr/pnr_ME/output/ME_extracted.spef.min

read_sdf ../pnr/pnr_ME/output/ME_extracted.sdf
## Read in SDC from the ICC
read_sdc ../pnr/pnr_ME/const/ME_extracted.sdc

set_case_analysis 0 scanEn
## Analysis reports

report_timing -from [all_inputs] -max_paths 20 -to [all_registers -data_pins] > reports/in2reg_timing.rpt
report_timing -from [all_register -clock_pins] -max_paths 20 -to [all_registers -data_pins]  > reports/reg2reg_timing.rpt
report_timing -from [all_registers -clock_pins] -max_paths 20 -to [all_outputs] > reports/reg2out_timing.rpt
report_timing -from [all_inputs] -to [all_outputs] -max_paths 20 > reports/in2reg_timing.rpt

#report_timing -from [all_registers -clock_pins] -to [all_registers -data_pins] -delay_type max  >> reports/timing.rpt
set_case_analysis 1 scanEn
report_timing -from [all_registers -clock_pins] -to [all_registers -data_pins] -delay_type min  > reports/timing.rpt

report_timing -transition_time -capacitance -nets -input_pins -from [all_registers -clock_pins] -to [all_registers -data_pins]  > reports/timing.tran.cap.rpt


## Save outputs
save_session output/ME.session

