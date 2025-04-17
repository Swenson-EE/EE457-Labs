#*******************************************************************************
#                                                                              *
#                   Copyright (C) 2010 Altera Corporation                      *
#                                                                              *
#  ALTERA, ARRIA, CYCLONE, HARDCOPY, MAX, MEGACORE, NIOS, QUARTUS & STRATIX    *
#  are Reg. U.S. Pat. & Tm. Off. and Altera marks in and outside the U.S.      *
#                                                                              *
#  All information provided herein is provided on as ?as is? basis, without    *
#  warranty of any kind.                                                       *
#                                                                              *
#  File Name: pipemult.sdc                                                     *
#                                                                              *
#  File Function: This file contains all the timing constraints for the        *
#       Quartus II Software Design Series:  Timing Analysis class, exercise 1. *
#                                                                              *
#  REVISION HISTORY:                                                           *
#   Revision 1.0    10/08/2010 - Initial Revision                              *
#   Revision 2.0	  10/20/2010 - Final version for 10.1								 *
# ******************************************************************************

# Create a base input clock into the FPGA

create_clock -period 10 -name clk1 [get_ports {clk1}]

# Create virtual clocks that clock the external devices that drive into the 
# FPGA inputs and are driven by the FPGA outputs for use with I/O timing

create_clock -period 10 -name clk1_in_virt
create_clock -period 10 -name clk1_out_virt

# Automatically derive clock uncertainties in the device

derive_clock_uncertainty

# Specify external delays on the FPGA inputs

set_input_delay -clock { clk1_in_virt } -max 1 [get_ports data*]
set_input_delay -clock { clk1_in_virt } -min .5 [get_ports data*]
set_input_delay -clock { clk1_in_virt } -max 1 [get_ports {rdaddress* wraddress*}]
set_input_delay -clock { clk1_in_virt } -min .5 [get_ports {rdaddress* wraddress*}]
set_input_delay -clock { clk1_in_virt } -max 1 [get_ports {wren}]
set_input_delay -clock { clk1_in_virt } -min 0.5 [get_ports {wren}]
#
## Specify external delays on the FPGA outputs
#
set_output_delay -clock { clk1_out_virt } -max 0.7 [get_ports q*]
set_output_delay -clock { clk1_out_virt } -min 0.0 [get_ports q*]