This program draws a line of pixels on the screen. Each pixel has a different color. The color number is incremented each time the column number is incremented, thus, giving a different color each time. To maintain one color, comment out the line where the color is incremented.

To assemble and run the bootloader either use the following command line:

`as pixel_line.s -o pixel_line.o && objcopy -O binary pixel_line.o pixel_line.bin && dd if=pixel_line.bin of=pixel_line.img && qemu-system-x86_64 -net none -drive format=raw,file=pixel_line.img`

Or, you can use the [bootscript.sh](https://github.com/Demkeys/x86-Assembly-ATT-Bootloaders/blob/master/PixelLineBoot/bootscript.sh) bash script. It does the exact same thing the above command line does.

![picture alt](https://github.com/Demkeys/x86-Assembly-ATT-Bootloaders/blob/master/PixelLineBoot/screencap02.png "Line of pixels")
