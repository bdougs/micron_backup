sudo service klipper stop
cd ~/klipper
git pull

make clean KCONFIG_CONFIG=config.octopus
make menuconfig KCONFIG_CONFIG=config.octopus
make KCONFIG_CONFIG=config.octopus
make flash FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_stm32f446xx_2B0028000850314D35323820-if00 KCONFIG_CONFIG=config.octopus

make clean KCONFIG_CONFIG=config.rpi
make menuconfig KCONFIG_CONFIG=config.rpi
make flash KCONFIG_CONFIG=config.rpi

make clean 
make menuconfig 
make 
python3 ~/CanBoot/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 235c74d5d81d

sudo service klipper start