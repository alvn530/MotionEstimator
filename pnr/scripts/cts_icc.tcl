###########################################################################
### Clock Tree Synthesis
###########################################################################

##In the Layout window, click on "Clock ", you will see various options, you can set any of the options to run CTS. If you click on Clock ' Core CTS and Optimization

##Save the Cell and report timing
##setup_time fix
clock_opt -only_cts


save_mw_cel -as fifo_cts
report_placement_utilization > reports/fifo_cts_util.rpt
report_qor_snapshot > reports/fifo_cts_qor_snapshot.rpt
report_qor > reports/fifo_cts_qor.rpt
##set_case_analysis 0 scanEn
report_timing -max_paths 20 -delay max > reports/fifo_cts.setup.rpt
##set_case_analysis 1 scanEn
report_timing -max_paths 20 -delay min > reports/fifo_cts.hold.rpt

