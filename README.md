# micron_backup
########### Hardware ###########

MCU
https://docs.vorondesign.com/build/software/octopus_klipper.html
	
	BTT Octopus v1.1
	STM32F446
	32KiB bootloader
	12 MHz clock
	Comm interface (USB (on PA11/PA12)
	serial: /dev/serial/by-id/usb-Klipper_stm32f446xx_2B0028000850314D35323820-if00
 


Toolhead
https://github.com/bigtreetech/EBB/tree/master/EBB%20CAN%20V1.1%20(STM32G0B1) 
	https://github.com/maz0r/klipper_canbus/blob/main/toolhead/ebb36-42_v1.1.md 
	
	EBB36 
	STM32G0B1
	8KiB offset
	8 MHz clock
	canbus UUID: 235c74d5d81d

Display
https://github.com/VoronDesign/Voron-Hardware/tree/master/V0_Display

	STM32F042
	no bootloader
	internal clock
	DFU [0483:df11]
	serial: /dev/serial/by-id/usb-Klipper_stm32f042x6_1A001A001343303054313620-if00
########### firmware ###########

auto update firmare command
~~~~~~~~~~~~~~~~~~~~~~~~~
cd ~/klipper
sudo bash update-all.sh
~~~~~~~~~~~~~~~~~~~~~~~~~
auto update firmware code
~~~~~~~~~~~~~~~~~~~~~~~~~
sudo service klipper stop
cd ~/klipper
git pull

#MCU
make clean KCONFIG_CONFIG=config.octopus
make menuconfig KCONFIG_CONFIG=config.octopus
make KCONFIG_CONFIG=config.octopus
make flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_stm32f446xx_2B0028000850314D35323820-if00 KCONFIG_CONFIG=config.octopus

#LinuxHost
make clean KCONFIG_CONFIG=config.rpi
make menuconfig KCONFIG_CONFIG=config.rpi
make flash KCONFIG_CONFIG=config.rpi

#toolhead
make clean 
make menuconfig 
make 
python3 ~/CanBoot/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 235c74d5d81d

#V0Display
#display serial: /dev/serial/by-id/usb-Klipper_stm32f042x6_1A001A001343303054313620-if00 DFU [0483:df11]
#make clean 
#make menuconfig 
#make
#make flash FLASH_DEVICE=0483:df11 

sudo service klipper start
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
