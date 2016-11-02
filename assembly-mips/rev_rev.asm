.data
buffer:			.space 1024
.text
main:

la	$a0, buffer
li	$a1, 100
li	$v0, 8
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
	
# printing reverse
	la	$t1, buffer
	add	$t1, $t1, $t3
	addi	$t1, $t1, -1
r_loop:	lb	$t2, 0($t1)
	
	li	$v0, 11
	addi	$a0, $t2, 0
	syscall
	
	addi	$t1, $t1, -1
	beqz	$t3, r_end
	addi	$t3, $t3, -1
	j 	r_loop
r_end:
	li	$v0, 10
	syscall
# end