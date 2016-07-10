# Author: Abdullah Ahmad Zarir

.data

message:	.asciiz "Enter N: "
space:		.asciiz	" "
d_space:	.asciiz "     "
newline:	.asciiz "\n"
N:		.word 0

ten:		.float .10

.text

main:
	la	$a0, message
	li	$v0, 4
	syscall		# printing message
	
	li	$v0, 5
	syscall		# taking input
	
	sw	$v0, N  # storing the input
	
	lw	$s0, N
	addi	$t0, $s0, -1
	li	$t1, 0	
	loop_top_o:
		beq $t1, $t0, end_loop_top_o
		
		addi $t2, $s0, -1
		sub $t2, $t2, $t1
		li   $t3, 0
		
		#addi	$a0, $t2, 0
		#li	$v0, 1
		#syscall
		#addi	$a0, $t3, 0
		#li	$v0, 1
		#syscall
		loop_top_f_i:
			beq $t3, $t2, end_loop_f_i
			la  $a0, d_space
			li  $v0, 4
			syscall
			
			addi $t3, $t3, 1	
			b	loop_top_f_i
		end_loop_f_i:
		
		sub $t2, $s0, $t3
		li  $t3, 0
		sub $t4, $s0, $t2
		addi	$t4, $t4, 1
		add $t2, $t2, $t1
		#la	$a0, ten
		
		#l.s	$f2, ten
		#mtc1.d $t4, $f3
		#cvt.s.w $f4, $f3
		#add.s 	$f6, $f4, $f2
		#addi	$a0, $t2, 0
		#li	$v0, 1
		#syscall
		#addi	$a0, $t4, 0
		#li	$v0, 1
		#syscall
		#jal terminate
		loop_top_s_i:
			beq $t3, $t2, end_loop_s_i
			#add.d  $f12, $f6, $f2
			li	$t9, 100
			mtc1	$t4, $f4
			mtc1	$t9, $f6
			cvt.s.w $f4, $f4
			cvt.s.w $f6, $f6
			div.s 	$f6, $f4, $f6
			add.s 	$f12, $f4, $f6
			#mul.s $f12, $f12, $f5
			#trunc.w.s $f12, $f12
			#cvt.s.w $f12, $f12
			#div.s $f12, $f12, $f5
			#addi	$a0, $t4, 0 
			li  $v0, 2
			syscall
			
			la  $a0, space
			li  $v0, 4
			syscall
			
			addi $t3, $t3, 1
			b	loop_top_s_i
		end_loop_s_i:
		addi	$t1, $t1, 1
		la $a0, newline
		li $v0, 4
		syscall
		b	loop_top_o
	end_loop_top_o:
	
	add	$t2, $s0, $s0
	addi	$t2, $t2, -1
	li	$t3, 0
	li	$t4, 1
	li	$t9, 100
	mtc1	$t4, $f4
	mtc1	$t9, $f6
	cvt.s.w $f4, $f4
	cvt.s.w $f6, $f6
	div.s 	$f6, $f4, $f6
	add.s 	$f12, $f4, $f6
	loop_mid_line:
		beq $t3, $t2, end_loop_mid_line
		#add.d  $f12, $f6, $f2
		
		li  $v0, 2
		syscall
		
		la  $a0, space
		li  $v0, 4
		syscall
		
		addi $t3, $t3, 1
		b	loop_mid_line
	end_loop_mid_line:
	
	la $a0, newline
	li $v0, 4
	syscall
	
	lw	$s0, N
	addi	$t0, $s0, -1
	li	$t1, 0	
	
	loop_bot_o:
		beq $t1, $t0, end_loop_bot_o
		
		addi $t2, $t1, 1
		#sub $t2, $t2, $t1
		li   $t3, 0
		
		loop_bot_f_i:
			beq $t3, $t2, end_loop_f_i_b
			la  $a0, d_space
			li  $v0, 4
			syscall
			
			addi $t3, $t3, 1	
			b	loop_bot_f_i
		end_loop_f_i_b:
		
		sub 	$t5, $t0, $t1
		add	$t2, $t5, $t5
		addi	$t2, $t2, -1
		#sub	$t2, $t2, $t5
		#sub	$t2, $t2, 
		
		#sub $t2, $s0, $t3
		li  $t3, 0
		#sub $t4, $s0, $t2
		addi	$t4, $t1, 2
		#addi $t2, $t2, $t2
		#la	$a0, ten
		
		#l.s	$f2, ten
		#mtc1.d $t4, $f3
		#cvt.s.w $f4, $f3
		#add.s 	$f6, $f4, $f2
		#addi	$a0, $t2, 0
		#li	$v0, 1
		#syscall
		#addi	$a0, $t4, 0
		#li	$v0, 1
		#syscall
		#jal terminate
		li	$t9, 100
		mtc1	$t4, $f4
		mtc1	$t9, $f6
		cvt.s.w $f4, $f4
		cvt.s.w $f6, $f6
		div.s 	$f6, $f4, $f6
		add.s 	$f12, $f4, $f6
		loop_top_s_i_b:
			beq $t3, $t2, end_loop_s_i_b
			#add.d  $f12, $f6, $f2
			li  $v0, 2
			syscall
			
			la  $a0, space
			li  $v0, 4
			syscall
			
			addi $t3, $t3, 1
			b	loop_top_s_i_b
		end_loop_s_i_b:
		addi	$t1, $t1, 1
		la $a0, newline
		li $v0, 4
		syscall
		b	loop_bot_o
	end_loop_bot_o:
	
terminate:
	li	$v0, 10
	syscall
	jr $ra
