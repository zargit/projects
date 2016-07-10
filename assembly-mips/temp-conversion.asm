# Author: Abdullah Ahmad Zarir

.data
test:		.asciiz "test"
space:		.asciiz " "
newline:	.asciiz "\n"
prompt_for_C:	.asciiz "Enter temperature in Celcius: "
prompt_for_F:	.asciiz "Enter temperature in Farenheit: "
prompt_for_R:	.asciiz "Enter temperature in Roman: "

in_celcius: 	.asciiz "\nIn Celcius: "
in_farenheit:	.asciiz "\nIn Farenheit: "
in_roman:	.asciiz "\nIn Roman: "

menu:		.asciiz "Choose Option:\n[1] Input Celcius\n[2] Input Farenheit\n[3] Input Roman\nEnter Option: "


pi:		.float	3.1416
_9:		.float	9.0
_5:		.float  5.0
_4:		.float  4.0
_32:		.float  32.0
zf:		.float	0.0
.text

main:
	# init vars
	l.s	$f7, _9
	l.s	$f8, _5
	l.s	$f9, _4
	l.s	$f10, _32
	l.s	$f11, zf

	# make a menu, input option
	la	$a0, menu
	jal	print_str
	jal	get_int
	move	$s0, $v0 	# $s0 has menu option
	
	beq	$s0, 1, opt_1
	beq	$s0, 2, opt_2
	beq	$s0, 3, opt_3
	b	exit
opt_1:

	# from celcius
	
	la	$a0, prompt_for_C
	jal 	print_str
	jal	get_float
	
	# to farenheit
	
	add.s	$f12, $f0, $f11
	mul.s	$f1, $f12, $f7
	div.s	$f1, $f1, $f8
	add.s	$f1, $f1, $f10
	mov.s	$f12, $f1
	
	la	$a0, in_farenheit
	jal 	print_str
	jal	print_float
	
	# to roman
	
	add.s	$f12, $f0, $f11
	mul.s	$f1, $f12, $f9
	div.s	$f1, $f1, $f8
	mov.s	$f12, $f1
	
	la	$a0, in_roman
	jal 	print_str
	jal	print_float
	
	b	exit
opt_2:

	# from farenheit
	
	la	$a0, prompt_for_F
	jal 	print_str
	jal	get_float
	
	# to celcius
	add.s	$f12, $f0, $f11	#copy
	sub.s	$f1, $f12, $f10
	div.s	$f1, $f1, $f7
	mul.s	$f1, $f1, $f8
	mov.s	$f12, $f1
	
	la	$a0, in_celcius
	jal 	print_str
	jal	print_float
	
	# to roman
	add.s	$f12, $f0, $f11	#copy
	sub.s	$f1, $f12, $f10
	div.s	$f1, $f1, $f7
	mul.s	$f1, $f1, $f9
	mov.s	$f12, $f1
	
	la	$a0, in_roman
	jal 	print_str
	jal	print_float
	
	b 	exit
opt_3:
	
	# from roman
	
	la	$a0, prompt_for_R
	jal 	print_str
	jal	get_float
	
	# to celcius
	
	add.s	$f12, $f0, $f11
	div.s	$f1, $f12, $f9
	mul.s	$f1, $f1, $f8
	mov.s	$f12, $f1
	
	la	$a0, in_celcius
	jal 	print_str
	jal	print_float
	
	# to farenheit
	
	add.s	$f12, $f0, $f11
	mul.s	$f1, $f12, $f7
	div.s	$f1, $f1, $f9
	add.s	$f1, $f1, $f10
	mov.s	$f12, $f1
	
	la	$a0, in_farenheit
	jal 	print_str
	jal	print_float
	
	b 	exit	
	# terminate
exit:
	li	$v0, 10
	syscall
	
get_int:
	li	$v0, 5
	syscall
	
	jr	$ra
	
get_float:
	li	$v0, 6
	syscall
	
	jr	$ra

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