# Author: Abdullah Ahmad Zarir

.data
# Strings
message:	.asciiz "Enter value-N:	"
space:		.asciiz " "
newline:	.asciiz "\n"

# Variables
N:		.word	0

.text
main:
# First take input N
	# Ask for input N
	li	$v0, 4
	la	$a0, message
	syscall
	
	# Take input and store in N
	li	$v0, 5
	syscall
	sw	$v0, N

# Now we have to run a loop for N times
	lw	$s0, N
	li	$t0, 0	# row_number
row:	beq	$t0, $s0, end

	# Now the first inner loop will run N-(row_number+1) times
	subu	$s1, $s0, $t0
	subu	$s1, $s1, 0x1
	
	# first inner loop(fip)
	li	$t1, 0
	fip:	beq	$t1, $s1, end_fip
	
		# Print space
		li	$v0, 4
		la 	$a0, space
		syscall
		
		# Increament the counter t1 and rerun loop
		addu	$t1, $t1, 0x1
		b	fip
	end_fip:
	
	# Now the second inner loop(sip) will run row_number times
	addu	$s2, $t0, 0x1
	
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
end:
	# Terminate program
	li	$v0, 10
	syscall
	
