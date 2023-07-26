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
make clean 
make menuconfig 
make
make flash FLASH_DEVICE=0483:df11 

sudo service klipper start