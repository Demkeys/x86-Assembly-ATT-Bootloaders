# This program draws a line of pixels on the screen. Each pixel has a different color. The color number is
# incremented each time the column number is incremented, thus, giving a different color each time.
# To maintain one color, comment out the line where the color is incremented.
	.code16
		
_start:
	movb $0x00, %ah		# Set video mode function
	movb $0x13, %al		# Video mode 13h
	int $0x10		# BIOS interrupt
	
	pushw %bp		# Prologue
	movw %sp, %bp		# Prologue

	pushw $0x20		# -2(%bp) = Color
	pushw $0xa		# -4(%bp) = Column current
	pushw $0x1f		# -6(%bp) = Column max

draw:
	movb $0x0C, %ah		# Function number
	movb $0x00, %bh		# Page number
	movb -2(%bp), %al	# Pixel color
	movw -4(%bp), %cx	# Column number
	movw $0x10, %dx		# Row number
	int $0x10		# BIOS Interupt
	
	incw -2(%bp)		# Increment Color number
	incw -4(%bp)		# Increment Column number
	movw -4(%bp), %ax
	cmpw -6(%bp), %ax	# Compare Column number and Column max
	jl draw			# If Column number less than Column max, jump to 'draw'


exit:	
	movw %bp, %sp		# Epilogue

	.org 510		# Advance location counter to 510, filling with zeros
	.word 0xaa55		# Bootloader signature
