current_name="barebonesboot"
assemblyfile_name="$current_name.s"
objectfile_name="$current_name.o"
binaryfile_name="$current_name.bin"
imagefile_name="$current_name.img"

as $assemblyfile_name -o $objectfile_name && objcopy -O binary $objectfile_name $binaryfile_name && dd if=$binaryfile_name of=$imagefile_name && qemu-system-x86_64 -net none -drive format=raw,file=$imagefile_name
