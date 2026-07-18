## Clock Signal (100 MHz onboard clock)
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Reset Signal (Center Push Button - BTNC)
set_property PACKAGE_PIN U18 [get_ports rst]						
	set_property IOSTANDARD LVCMOS33 [get_ports rst]

## Pedestrian Request Signal (Right Push Button - BTNR)
set_property PACKAGE_PIN T17 [get_ports ped_request]						
	set_property IOSTANDARD LVCMOS33 [get_ports ped_request]

## ====================================================================
## External Main Road LEDs (Connected via External Ports)
## ====================================================================
# Main Road Green -> Port A16
set_property PACKAGE_PIN A16 [get_ports {main_road[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {main_road[0]}]

# Main Road Yellow -> Port A15 
set_property PACKAGE_PIN A15 [get_ports {main_road[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {main_road[1]}]

# Main Road Red -> Port B16
set_property PACKAGE_PIN B16 [get_ports {main_road[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {main_road[2]}]

## ====================================================================
## External Side Road LEDs (Connected via External Ports)
## ====================================================================
# Side Road Green -> Port M18
set_property PACKAGE_PIN M18 [get_ports {side_road[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {side_road[0]}]

# Side Road Yellow -> Port N17
set_property PACKAGE_PIN N17 [get_ports {side_road[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {side_road[1]}]

# Side Road Red -> Port P18
set_property PACKAGE_PIN P18 [get_ports {side_road[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {side_road[2]}]

## ====================================================================
## Configuration Bits
## ====================================================================
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
