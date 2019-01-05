This bootloader draws graphics pixels to create a rainbow flag on the screen.

_NOTE: This code is not optimized at all. There are definitely better, more optimized methods of doing this. This method is not meant to be the best method, it's just one of the methods you can use to draw a rainbow flag._

To assemble and run the bootloader either use the following command line:

`as rainbow_flag.s -o rainbow_flag.o && objcopy -O binary rainbow_flag.o rainbow_flag.bin && dd if=rainbow_flag.bin of=rainbow_flag.img && qemu-system-x86_64 -net none -drive format=raw,file=rainbow_flag.img`

Or, you can use the [bootscript.sh](https://github.com/Demkeys/x86-Assembly-ATT-Bootloaders/blob/master/RainbowFlagBoot/bootscript.sh) bash script. It does the exact same thing the above command line does.

![](https://github.com/Demkeys/x86-Assembly-ATT-Bootloaders/blob/master/RainbowFlagBoot/screencap02.png)
