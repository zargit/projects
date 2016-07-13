# Author: Abdullah Ahmad Zarir

.data

filename:		.asciiz "letter.txt"
output_filename:	.asciiz "revletter.txt"
buffer:			.space 1024

.text

main:

# opening file
	la	$a0, filename
	li 	$a1, 0
	li	$v0, 13
	li	$a2, 0
	syscall
	move 	$s6, $v0
	
# reading from file
	li	$v0, 14
	move	$a0, $s6	# $s6 contains file address
	la	$a1, buffer
	li 	$a2, 1024
	syscall
	
# counting letters
	li	$t3, 0	
	la	$t1, buffer
loop:	lb	$t2, 0($t1)
	beq	$t2, '\0', end
	addi	$t3, $t3, 1
	addi 	$t1, $t1, 1
	j 	loop
end:
	addi	$a0, $t3, 0

# opening file for output
	la	$a0, output_filename
	li 	$a1, 1
	li	$v0, 13
	li	$a2, 0
	syscall
	move 	$s6, $v0
	
# printing reverse
	la	$t1, buffer
	add	$t1, $t1, $t3
	addi	$t1, $t1, -1
r_loop:	lb	$t2, 0($t1)
	
	li	$v0, 15
	addi	$a0, $s6, 0
	addi 	$a1, $t1, 0
	addi 	$a2, $zero, 1
	syscall
	
	addi	$t1, $t1, -1
	beqz	$t3, r_end
	addi	$t3, $t3, -1
	j 	r_loop
r_end:
	li	$v0, 10
	syscall
	
# end
	
	
	
	