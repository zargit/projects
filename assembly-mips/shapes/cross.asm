#Author: Abdullah Ahmad Zarir

.data
# Strings
message:	.asciiz "Enter value-N:	"
space:		.asciiz " "
ds:		.asciiz "  "
newline:	.asciiz "\n"

# Variables
N:		.word	0
two:		.word	2

.text
main:
	lw	$t6, two
# First take input N
	# Ask for input N
	li	$v0, 4
	la	$a0, message
	syscall
	
	# Take input and store in N
	li	$v0, 5
	syscall
	sw	$v0, N

# Now we have to run a loop for N/2 times
	lw	$s0, N
	div	$s0, $s0, $t6
	li	$t0, 0	# row_number
row:	beq	$t0, $s0, end_row

	# Now the first inner loop will run N/2 times
	lw	$t5, N
	div	$s1, $t5, $t6
	#subu	$s1, $s1, 1
	
	# first inner loop(fip)
	li	$t1, 0
	fip:	beq	$t1, $s1, end_fip
	
		# Print space
		
		la 	$a0, ds
		jal 	print_str
		
		# Increament the counter t1 and rerun loop
		addu	$t1, $t1, 0x1
		b	fip
	end_fip:
	
	# Now the second inner loop(sip) will run row_number times
	addu	$s2, $t0, 1
	
	li	$t2, 0
	sip:	beq	$t2, $s2, end_sip
		
		# First print symbol
		li	$v0, 11
		addu	$a0, $t0, 65
		syscall
		
		# Second print space
		li	$v0, 4
		la	$a0, space
		syscall
		
		# Increament the counter t2 and rerun loop
		addu	$t2, $t2, 0x1
		b	sip
	end_sip:
	
	# Print a new line at the end
	li	$v0, 4
	la	$a0, newline
	syscall
	
	# Increament the counter t0 and rerun loop
	addu	$t0, $t0, 0x1
	b	row
end_row:	
	lw	$s2, N
	li	$t2, 0
mid:	beq	$t2, $s2, end_mid
		
	# First print symbol
	li	$v0, 11
	addu	$a0, $t0, 65
	syscall
	
	# Second print space
	li	$v0, 4
	la	$a0, space
	syscall
		
	# Increament the counter t2 and rerun loop
	addu	$t2, $t2, 0x1
	b	mid
end_mid:

#print a line
la	$a0, newline
jal	print_str


# Now we have to run a loop for N/2 times for the bottom part
	lw	$s0, N
	div	$s0, $s0, $t6
	li	$t0, 0	# row_number
row_bot:	
	beq	$t0, $s0, end

	# Now the first inner loop will run N/2 times
	lw	$t5, N
	div	$s1, $t5, $t6
	#subu	$s1, $s1, 1
	
	# first inner loop(fip)
	li	$t1, -1
	fip_bot:	beq	$t1, $t0, end_fip_bot
	
		# Print space
		
		la 	$a0, ds
		jal 	print_str
		
		# Increament the counter t1 and rerun loop
		addu	$t1, $t1, 0x1
		b	fip_bot
	end_fip_bot:
	
	# Now the second inner loop(sip) will run row_number times
	lw	$t5, N
	div	$s2, $t5, 2
	
	addu	$t2, $t0, $zero
	sip_bot:	beq	$t2, $s2, end_sip_bot
		
		# First print symbol
		li	$v0, 11
		lw	$t5, N
		div	$t5, $t5, $t6
		addu 	$t5, $t5, 66
		addu	$a0, $t0, $t5
		syscall
		
		# Second print space
		li	$v0, 4
		la	$a0, space
		syscall
		
		# Increament the counter t2 and rerun loop
		addu	$t2, $t2, 0x1
		b	sip_bot
	end_sip_bot:
	
	# Print a new line at the end
	la	$a0, newline
	jal	print_str
	
	# Increament the counter t0 and rerun loop
	addu	$t0, $t0, 0x1
	b	row_bot
end_row_bot:	
	lw	$s2, N
	li	$t2, 0


end:
	# Terminate program
	li	$v0, 10
	syscall

print_int:
	li	$v0, 1
	syscall
	
	jr	$ra

print_float:
	li	$v0, 2
	syscall
	
	jr	$ra
	
print_str:
	li	$v0, 4
	syscall
	
	jr	$ra
	
