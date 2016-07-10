# Author: Abdullah Ahmad Zarir

.data

message:	.asciiz "Enter a number: "
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
	
	li	$t0, 0 # index
	add	$t1, $s0, $s0
	addi	$t1, $t1, -1 #  $t1 = 2*n-1
	top_line:
		beq	$t0, $t1, end_top_line
		
		li	$t9, 100
		addi	$t4, $s0, 0
		mtc1	$t4, $f4
		mtc1	$t9, $f6
		cvt.s.w $f4, $f4
		cvt.s.w $f6, $f6
		div.s 	$f6, $f4, $f6
		add.s 	$f12, $f4, $f6
		li	$v0, 2
		syscall
		
		la	$a0, space
		li	$v0, 4
		syscall
				
		addi	$t0, $t0, 1
		b	top_line
	end_top_line:
	
	# end of line
	la	$a0, newline
	li	$v0, 4
	syscall	
	
	li	$t0, 1 # index
	addi	$t1, $s0, 0
	#addi	$t1, $t1, -1 #  $t1 = 2*n-1
	first_outer_loop:
		beq 	$t0, $t1, end_fol
		
		li	$t2, 0 # index
		sub	$t3, $s0, $t0 #  $t3 = n-1
		#addi	$t3, $t3, -1 
		sub	$t4, $s0, $t0 
		first_top_inner_loop:
			beq	$t2, $t3, end_ftil
			
			li	$t9, 100
			mtc1	$t4, $f4
			mtc1	$t9, $f6
			cvt.s.w $f4, $f4
			cvt.s.w $f6, $f6
			div.s 	$f6, $f4, $f6
			add.s 	$f12, $f4, $f6
			li	$v0, 2
			syscall
			
			la	$a0, space
			li	$v0, 4
			syscall
		# increament counter $t2
		addi	$t2, $t2, 1	
		b	first_top_inner_loop	
		end_ftil:
		
		
		li	$t2, 0 # index
		add	$t3, $t0, $t0 #  $t3 = n-1
		addi	$t3, $t3, -1 
		sub	$t4, $s0, $t0 
		second_top_inner_loop:
			beq	$t2, $t3, end_stil
			
			li	$v0, 4
			la	$a0, d_space
			syscall
			
		# increament counter $t2
		addi	$t2, $t2, 1	
		b	second_top_inner_loop	
		end_stil:

		
		li	$t2, 0 # index
		sub	$t3, $s0, $t0  #  $t3 = n-1
		#addi	$t3, $t3, -1 
		sub	$t4, $s0, $t0 
		third_top_inner_loop:
			beq	$t2, $t3, end_ttil
			
			li	$t9, 100
			mtc1	$t4, $f4
			mtc1	$t9, $f6
			cvt.s.w $f4, $f4
			cvt.s.w $f6, $f6
			div.s 	$f6, $f4, $f6
			add.s 	$f12, $f4, $f6
			li	$v0, 2
			syscall
			
			la	$a0, space
			li	$v0, 4
			syscall
		# increament counter $t2
		addi	$t2, $t2, 1	
		b	third_top_inner_loop	
		end_ttil:
		
		# end of line
		la	$a0, newline
		li	$v0, 4
		syscall		
		# increament counter $t0
		addi	$t0, $t0, 1
		b	first_outer_loop
	end_fol:
	
	li	$t1, 0 # index
	addi	$t0, $s0, -2
	#addi	$t1, $t1, -1 #  $t1 = 2*n-1
	second_outer_loop:
		beq 	$t0, $t1, end_sol
		
		li	$t2, 0 # index
		sub	$t3, $s0, $t0 #  $t3 = n-1
		#addi	$t3, $t3, -1 
		sub	$t4, $s0, $t0 
		first_bot_inner_loop:
			beq	$t2, $t3, end_fbil
			
			li	$t9, 100
			mtc1	$t4, $f4
			mtc1	$t9, $f6
			cvt.s.w $f4, $f4
			cvt.s.w $f6, $f6
			div.s 	$f6, $f4, $f6
			add.s 	$f12, $f4, $f6
			li	$v0, 2
			syscall
			
			la	$a0, space
			li	$v0, 4
			syscall
		# increament counter $t2
		addi	$t2, $t2, 1	
		b	first_bot_inner_loop	
		end_fbil:
		
		
		li	$t2, 0 # index
		add	$t3, $t0, $t0 #  $t3 = n-1
		addi	$t3, $t3, -1 
		sub	$t4, $s0, $t0 
		second_bot_inner_loop:
			beq	$t2, $t3, end_sbil
			
			li	$v0, 4
			la	$a0, d_space
			syscall
			
		# increament counter $t2
		addi	$t2, $t2, 1	
		b	second_bot_inner_loop	
		end_sbil:

		
		li	$t2, 0 # index
		sub	$t3, $s0, $t0  #  $t3 = n-1
		#addi	$t3, $t3, -1 
		sub	$t4, $s0, $t0 
		third_bot_inner_loop:
			beq	$t2, $t3, end_tbil
			
			li	$t9, 100
			mtc1	$t4, $f4
			mtc1	$t9, $f6
			cvt.s.w $f4, $f4
			cvt.s.w $f6, $f6
			div.s 	$f6, $f4, $f6
			add.s 	$f12, $f4, $f6
			li	$v0, 2
			syscall
			
			la	$a0, space
			li	$v0, 4
			syscall
			
		# increament counter $t2
		addi	$t2, $t2, 1	
		b	third_bot_inner_loop	
		end_tbil:
		
		# end of line
		la	$a0, newline
		li	$v0, 4
		syscall		
		# increament counter $t0
		addi	$t0, $t0, -1
		b	second_outer_loop
	end_sol:
	
	li	$t0, 0 # index
	add	$t1, $s0, $s0
	addi	$t1, $t1, -1 #  $t1 = 2*n-1
	bot_line:
		beq	$t0, $t1, end_bot_line
		
		li	$t9, 100
		addi	$t4, $s0, 0
		mtc1	$t4, $f4
		mtc1	$t9, $f6
		cvt.s.w $f4, $f4
		cvt.s.w $f6, $f6
		div.s 	$f6, $f4, $f6
		add.s 	$f12, $f4, $f6
		li	$v0, 2
		syscall
		
		la	$a0, space
		li	$v0, 4
		syscall
				
		addi	$t0, $t0, 1
		b	bot_line
	end_bot_line:
			
	
terminate:
	li	$v0, 10
	syscall
	jr $ra
