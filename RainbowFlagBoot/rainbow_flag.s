	.code16
_start:
	pushw %bp
	movw %sp, %bp

	# This is line is necessary because of legacy reasons. An earlier version of 
	# this code pushed 6 words to the stack. Over time as the program progressed,
	# those 6 words became useless, but by that time %bp offsets were being used
	# all over the code. So to avoid having to change all of the offsets, we
	# subtract 0xc (6 words) from the stack pointer value.
	subw $0xc, %sp
	
	###############################################
	# Push required values on to the stack
	###############################################
	pushw $0x10		# -14(%bp) Flag length current
	pushw $0x12f		# -16(%bp) Flag length max
	pushw $0x00		# -18(%bp) Flag height current
	pushw $0xbf		# -20(%bp) Flag height max
	subw $0x4, %sp		# Again, legacy reasons (read above).
	pushw $0x28		# -26(%bp) Strip color current
	###############################################

set_video_mode:
	movb $0x00, %ah		# Function: Set video mode
	movb $0x13, %al		# Video mode 13h
	int $0x10		# BIOS interrupt

write_graphics_pixel:		
	movb $0x0C, %ah		# Function: Write graphics pixel
	movb $0x0, %bh		# Page number
	movb -26(%bp), %al	# Pixel color
	movw -14(%bp), %cx	# Column
	movw -18(%bp), %dx	# Row
	int $0x10		# BIOS interrupt

inc_flag_length:
	incw -14(%bp)		# Increment Flag Length Current
	movw -16(%bp), %ax	# Move Flag Length Max to AX
	cmpw %ax, -14(%bp)	# Compare Flag Length Current with Flag Length Max
	jl write_graphics_pixel	# If Flag Length Current less than Flag Length Max, jump.
	movw $0x10, -14(%bp)	# Else, reset Flag Length Current to 0x10
	jge inc_flag_height	# If Flag Length Current greater than or equal to Flag Length Max, jump.

check_strip_height:
	movw -18(%bp), %cx	# Move Flag Height Current to CX

	############################################################
	# These instructions change Flag Color Current depending on
	# the value of Flag Height Current
	############################################################
	movw $0x020, %dx	
	cmpw %dx, %cx
	jl write_graphics_pixel # Keep color same if Flag Height Current is less than 0x20

	movw $0x40, %dx
	cmpw %dx, %cx
	jl change_to_orange	# Change color if Flag Height Current is less than 0x40

	movw $0x60, %dx
	cmpw %dx, %cx
	jl change_to_yellow	# Change color if Flag Height Current is less than 0x60

	movw $0x80, %dx
	cmpw %dx, %cx
	jl change_to_green	# Change color if Flag Height Current is less than 0x80
	
	movw $0xa0, %dx
	cmpw %dx, %cx
	jl change_to_blue	# Change color if Flag Height Current is less than 0xa0

	movw $0xc0, %dx
	cmpw %dx, %cx
	jl change_to_violet	# Change color if Flag Height Current is less than 0xc0
	###########################################################

change_to_orange:
	movw $0x2a, -26(%bp)	# Set Strip Color Current to Orange
	jmp write_graphics_pixel
change_to_yellow:
	movw $0x2c, -26(%bp)	# Set Strip Color Current to Yellow
	jmp write_graphics_pixel
change_to_green:
	movw $0x2f, -26(%bp)	# Set Strip Color Current to Green
	jmp write_graphics_pixel
change_to_blue:
	movw $0x37, -26(%bp)	# Set Strip Color Current to Blue
	jmp write_graphics_pixel
change_to_violet:
	movw $0x22, -26(%bp)	# Set Strip Color Current to Violet
	jmp write_graphics_pixel	

inc_flag_height:
	incw -18(%bp)		# Increment Flag Height Current
	movw -20(%bp), %ax	# Move Flag Height Max to AX
	cmpw %ax, -18(%bp)	
	jl check_strip_height	# If Flag Height Current is less than Flag Height Max, jump.

	# If Flag Height Current is not less than Flag Height Max, the flag is complete.
exit:
	movw %bp, %sp		# Epilogue

	.org 510		# Advance location counter to 510.
	.word 0xaa55		# Bootloader signature.
