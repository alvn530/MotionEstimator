###############################################################################
#
# Created by PrimeTime write_sdc on Sun Dec 20 18:50:02 2020
#
###############################################################################

set sdc_version 2.0

set_units -time ns -capacitance fF -current uA -voltage V -resistance 1MOhm
###############################################################################
#  
# Units
# capacitive_load_unit           : 0.001 pF
# current_unit                   : 1e-06 A
# resistance_unit                : 1000 kOhm
# time_unit                      : 1 ns
# voltage_unit                   : 1 V
###############################################################################
set_operating_conditions -analysis_type on_chip_variation  -library [get_libs \
 {saed32hvt_ff0p95v125c.db:saed32hvt_ff0p95v125c}] 
###############################################################################
# Clock Related Information
###############################################################################
create_clock -name ideal_clock1 -period 3.486 -waveform { 0 1.743 } [get_ports \
 {clock}]
###############################################################################
# Clock Latency Infomation
###############################################################################
set_propagated_clock [get_ports {clock}]
###############################################################################
# External Delay Information
###############################################################################
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {start}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {R[7]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {R[6]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {R[5]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {R[4]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {R[3]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {R[2]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {R[1]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {R[0]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S1[7]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S1[6]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S1[5]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S1[4]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S1[3]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S1[2]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S1[1]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S1[0]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S2[7]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S2[6]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S2[5]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S2[4]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S2[3]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S2[2]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S2[1]}]
set_input_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {S2[0]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {AddressR[7]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {AddressR[6]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {AddressR[5]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {AddressR[4]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {AddressR[3]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {AddressR[2]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {AddressR[1]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {AddressR[0]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS1[9]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS1[8]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS1[7]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS1[6]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS1[5]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS1[4]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS1[3]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS1[2]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS1[1]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS1[0]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS2[9]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS2[8]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS2[7]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS2[6]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS2[5]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS2[4]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS2[3]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS2[2]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS2[1]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports \
 {AddressS2[0]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {BestDist[7]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {BestDist[6]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {BestDist[5]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {BestDist[4]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {BestDist[3]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {BestDist[2]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {BestDist[1]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {BestDist[0]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {motionX[3]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {motionX[2]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {motionX[1]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {motionX[0]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {motionY[3]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {motionY[2]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {motionY[1]}]
set_output_delay  0 -clock [get_clocks {ideal_clock1}] [get_ports {motionY[0]}]
set_max_area 0
