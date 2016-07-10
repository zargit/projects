# Author: Abdullah Ahmad Zarir

.data

### Prompt
ask_character:		.asciiz "\nEnter character : "
word_filename:		.asciiz "word.txt"
input_filename:		.asciiz "input.txt"
output_filename:	.asciiz "output.txt" 
total_match:		.asciiz "\nTotal match found: "

input_buffer:		.space 1024
length:			.word	0
word_len:		.byte	0
space:			.asciiz " "
newline:		.asciiz "\n"

space_byte:		.byte '\n'
.text

main:
#################Opening file for input#############
	la	$a0, word_filename
	li 	$a1, 0
	jal	open_file
	
################Reading from file###################
	li	$v0, 14
	move	$a0, $s6	# $s6 contains file address
	la	$a1, input_buffer
	li 	$a2, 1024
	syscall

###############Opening file for output##############
	la	$a0, output_filename
	li 	$a1, 1
	jal	open_file

#####Identifying and then evaluating each Word######
	li	$t0, 0	
	li	$t4, 0 # storing each word length
	la	$t1, input_buffer
	li	$s3, 0	# total match found
	li	$s7, 0  # total vowels
loop:	lb	$t2, 0($t1)
	beq	$t2, '\0', end # checking end of input
	li 	$t9, 0 # flag for 'w' - word
	
	beq	$t2, 'a', vowel
	beq	$t2, 'A', vowel
	beq	$t2, 'e', vowel
	beq	$t2, 'E', vowel
	beq	$t2, 'i', vowel
	beq	$t2, 'I', vowel
	beq	$t2, 'o', vowel
	beq	$t2, 'O', vowel
	beq	$t2, 'u', vowel
	beq	$t2, 'U', vowel
	j 	not_vowel
	vowel:
	addi 	$s7, $s7, 1
	addi 	$t9, $zero, 1
	li 	$v0, 11
	addi 	$a0, $t2, 0
	syscall
	################Writing to file################
	li	$v0, 15
	addi	$a0, $s6, 0
	addi 	$a1, $t1, 0
	addi 	$a2, $zero, 1
	syscall
	# write a newline
	li	$v0, 15
	addi	$a0, $s6, 0
	la	$a1, newline
	li	$a2, 1
	syscall
	############Writing to file ends here##################
	not_vowel:
	endif:
	addi	$t0, $t0, 1	# counting string length
	addi	$t1, $t1, 1	# moving address to the right
	j	loop
end:
	la	$a0, total_match
	jal	print_str
	
	addi	$a0, $s7, 0
	jal	print_int
###########Terminating Program############
exit:
	li	$v0, 10
	syscall

#######Supports Functions Below###########

# Function for opening a file
# Filename is stored in $a0, operation type in $a1 (read or write)
# After opening, the file address will be stored in $s6
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
