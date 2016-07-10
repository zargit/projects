# Author: Abdullah Ahmad Zarir

.data

### Prompt
ask_character:		.asciiz "\nEnter character : "
word_filename:		.asciiz "word.txt"
input_filename:		.asciiz "input.txt"
output_filename:	.asciiz "output.txt" 
help:			.asciiz "#### Extract Words ####\n\nGuideline:\n1) Put the file in the same folder as Mars and name it 'word.txt'\n2) Enter a character (case insensitive), then all the words beginnig with that letter will be displayed.\n\n"
total_match:		.asciiz "\nTotal match found: "

input_buffer:		.space 1024
length:			.word	0
word_len:		.byte	0
space:			.asciiz " "
newline:		.asciiz "\n"

space_byte:		.byte '\n'
.text

main:

################# Display Guideline ################
	la 	$a0, help
	jal	print_str
	
####### Input Character to Extract Words ###########
	la 	$a0, ask_character
	jal	print_str
	
	li	$v0, 12
	syscall
	move 	$s5, $v0
	slti	$a0, $s5, 'a'
	beqz	$a0, ch_end
	addi	$s4, $s5, 32
	b	ch2_end
	ch_end:
	addi	$s4, $s5, -32
	ch2_end:
	la	$a0, newline
	jal 	print_str
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
loop:	lb	$t2, 0($t1)
	beq	$t2, '\0', end # checking end of input
	li 	$t9, 0 # flag for 'w' - word
	
	bne	$t2, ' ', check_comma
	b	end_of_word
	check_comma:
	bne	$t2, ',', check_fullstop
	b	end_of_word
	check_fullstop:
	bne	$t2, '.', if
	end_of_word:
	sub	$s0, $t1, $t4 	# start point
	sub	$s1, $t1, $zero	# end point
	lb 	$a0, 0($s0)
	bne 	$a0, $s5, check_W	# check if its starts with upper/lower character
	li $t9, 1			# if yes make flag $t9 = 1
	addi	$s3, $s3, 1 # incrementing total match found
	b	loop_print_word		# or 
	check_W:
	bne     $a0, $s4, end_p_w	# check if its starts with upper/lower character
	li $t9, 1			# if yes make flag $t9 = 1
	addi	$s3, $s3, 1 # incrementing total match found
	
	loop_print_word:
	################Printing to console############			
		beq $s0, $s1, end_p_w # loop from start to end point of word
		#syscall
		lb $a0, 0($s0)
		jal print_char
		addi $s0, $s0, 1
		b loop_print_word
	###############################################
	end_p_w:
	################Writing to file################
	bne 	$t9, 1, skip
	li	$v0, 15
	sub 	$s0, $t1, $t4
	addi	$a0, $s6, 0
	addi 	$a1, $s0, 0
	addi 	$a2, $t4, 0
	syscall
	# write a newline
	li	$v0, 15
	addi	$a0, $s6, 0
	la	$a1, newline
	li	$a2, 1
	syscall
	############Writing to file ends here##################
	la	$a0, newline
	jal	print_str
	skip:
	li	$t4, 0	# ($t2 == ' ') renewing after we find a stop character
	j	endif
	if:
	beq	$t2, '.', endif # not increasing word length if '.'
	beq	$t2, ',', endif # not increasing word length if ','
	addi	$t4, $t4, 1 	# incresing word length
	endif:
	addi	$t0, $t0, 1	# counting string length
	addi	$t1, $t1, 1	# moving address to the right
	j	loop
end:
	la	$a0, total_match
	jal	print_str
	
	addi	$a0, $s3, 0
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
