# Author: Abdullah Ahmad Zarir

.data
filename:	.asciiz "palindrome.txt"
input_buffer:	.space 1024

space:		.asciiz " "
length:		.word	0

.text

main:
#-----------Opening file for input---------------#
	la	$a0, filename
	li 	$a1, 0
	jal	open_file
	
#-------------Reading from file-----------#
	li	$v0, 14
	move	$a0, $s6	# $s6 contains file address
	la	$a1, input_buffer
	li 	$a2, 1024
	syscall
	
######Iterating through the string#####

	li	$t0, 0	
	li	$t4, 0 # storing each word length
	la	$t1, input_buffer
loop:	lb	$t2, 0($t1)
	beq	$t2, '\0', end # checking end of input
	li 	$t9, 1 # flag for palindrome, assuming true in the beginning 

	# space(' '), comma(',') and dot('.') indicates end of word
	bne	$t2, ' ', check_comma
	b	end_of_word
	check_comma:
	bne	$t2, ',', check_fullstop
	b	end_of_word
	check_fullstop:
	bne	$t2, '.', if
	end_of_word:
	sub	$s0, $t1, $t4 	# start point of a word
	sub	$s1, $t1, $zero	# end point of the word
	addi	$s2, $s1, -1
	
	# iterating throught the word
	
	loop_check_pal:	# this loop checks if its a palindrome or not
		beq $s0, $s1, end_p_w
		lb $a0, 0($s0) # from left side
		lb $a1, 0($s2) # from right side
		slti $a2, $a0, 97
		bne $a2, 1, no_left_convert
		addi $a0, $a0, 32 # converting to lower case
		no_left_convert:
		slti $a2, $a1, 97
		bne $a2, 1, no_right_convert
		addi $a1, $a1, 32 # converting to lower case
		no_right_convert:
		beq $a0, $a1, continue # if character in opposite ends are same then we move on to check the next opposite side characters
		li $t9, 0 # if $t9==0 that means not a palindrome
		b	end_p_w
		continue: 
		addi $s0, $s0, 1
		addi $s2, $s2, -1
		b loop_check_pal
	end_p_w:
	bne 	$t9, 1, end_p # if its a palindrome then we print the word
	sub	$s0, $t1, $t4 	# start point of palindrome word
	sub	$s1, $t1, $zero	# end point of palindrome word
	loop_print_word:
		beq $s0, $s1, end_p
		lb $a0, 0($s0) # from left side 
		jal print_char
		addi $s0, $s0, 1
		b loop_print_word
	end_p:
	bne 	$t9, 1, no_space
	la 	$a0, space
	jal	print_str	
	no_space:
	li	$t4, 0	# ($t2 == ' ')
	j	endif
	if:
	beq	$t2, '.', endif
	beq	$t2, ',', endif
	addi	$t4, $t4, 1 # incresing word length
	endif:
	addi	$t0, $t0, 1	# counting string length
	addi	$t1, $t1, 1	# moving addreess to the right
	j	loop
end:
	sw	$t0, length
	addi	$a0, $t0, 0
	
###############Terminate###############
	li	$v0, 10
	syscall
#-------------------------------------#

###########Support Functions###########
open_file:
	li	$v0, 13
	li	$a2, 0
	syscall
	move 	$s6, $v0
	jr 	$ra

print_str:
	li	$v0, 4
	syscall
	jr	$ra

print_char:
	li	$v0, 11
	syscall
	jr 	$ra

print_int:
	li	$v0, 1
	syscall
	jr	$ra
