This bootloader does nothing. It just boots.

To assemble and run the bootloader either use the following command line:

`as barebonesboot.s -o barebonesboot.o && objcopy -O binary barebonesboot.o barebonesboot.bin && dd if=barebonesboot.bin of=barebonesboot.img && qemu-system-x86_64 -net none -drive format=raw,file=barebonesboot.img`

Or, you can use the [bootscript.sh](https://github.com/Demkeys/x86-Assembly-ATT-Bootloaders/blob/master/BarebonesBoot/bootscript.sh) bash script. It does the exact same thing the above command line does.
