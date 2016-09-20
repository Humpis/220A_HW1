# Homework #1
# name: Vidar Minkovsky
# sbuid: 109756598

.data
	.align 2
	numargs: .word 0
	arg1: .word 0
	arg2: .word 0
	arg3: .word 0
	Err_string: .asciiz "ARGUMENT ERROR"
	Part1_string: .asciiz "ARG2: "
	Part2_string: .asciiz "ARG3: "
	Space: .asciiz " "
	NewLine: .asciiz "\n"
	HammingDist: .asciiz "Hamming Distance: "
	Sum: .asciiz "sum: "
	LastVal: .asciiz "Last value drawn: "
	TotalVal: .asciiz "Total values: "
	Odd: .asciiz "# of Odd: "
	Even: .asciiz "# of Even: "
	Power2: .asciiz "Power of 2: "
	Mult2: .asciiz "Multiple of 2: "
	Mult4: .asciiz "Multiple of 4: "
	Mult8: .asciiz "Multiple of 8: "
# Helper macro for grabbing command line arguments
.macro load_args
	sw $a0, numargs
	lw $t0, 0($a1)
	sw $t0, arg1
	lw $t0, 4($a1)
	sw $t0, arg2
	lw $t0, 8($a1)
	sw $t0, arg3
.end_macro

.text
.globl main
main:
	load_args() 			# Only do this once
	blt $a0, 4, lessthan4		# if there are more than 3 args
	li $v0, 4			# print error
	la $a0, Err_string
	syscall
	j exit
	
lessthan4:
	bgt $a0, 1, NumArgsGood		# if there are less than 2 args
	li $v0, 4			# print error
	la $a0, Err_string
	syscall
	j exit

NumArgsGood:
	lw $t0, arg1			# put location of arg1 in t0
	lb $s0, ($t0)  			# put char from arg1 in s0
	addi $t0, $t0, 1		# increment arg1
	lb $t2, 0($t0)			# put second char from arg1 in t2
	beqz $t2, arg1is1Char
	li $v0, 4			# print error
	la $a0, Err_string
	syscall
	j exit
	
arg1is1Char:
	beq $s0, 'A', arg1_A		# string[i] is "A"
	beq $s0, 'R', arg1_R		# string[i] is "R"
	beq $s0, 'a', arg1_A		# string[i] is "A"
	beq $s0, 'r', arg1_R		# string[i] is "R"
	li $v0, 4			# print error
	la $a0, Err_string
	syscall
	j exit
	
arg1_A:
	lw $t0, arg2			# put location of arg2 in t0
	beqz $t0, error			# no arg 2
	lw $t0, arg3			# put location of arg3 in t0
	beqz $t0, error			# no arg 3
	
	lw $t0, arg2			# put location of arg2 in t0
	lb $s1, ($t0)			# put 1st char in s1 
	addi $t0, $t0, 1		# advance to next char
	lb $s2, ($t0)			# do dsame for 2-4
	addi $t0, $t0, 1		
	lb $s3, ($t0)			
	addi $t0, $t0, 1		
	lb $s4, ($t0)			 
	
	li $v0, 4			# print arg2
	la $a0, Part1_string
	syscall
	
	li $t0, 0
	move $t0, $s1			# move first letter
	sll $t1, $s2, 8			# move second
	add $t0, $t0, $t1
	sll $t1, $s3, 16		# move 3
	add $t0, $t0, $t1
	sll $t1, $s4, 24		# move 4
	add $t0, $t0, $t1		# move 4
	move $s6, $t0			# move for hamming
	
	li $v0, 35			# print arg2 in bin
	la $a0, ($t0)
	syscall
	
	li $v0, 4			# print space
	la $a0, Space
	syscall
	
	li $v0, 34			# print arg2 in hex
	la $a0, ($t0)
	syscall
	
	li $v0, 4			# print space
	la $a0, Space
	syscall
	
	li $v0, 1			# print arg2 in 2s comp
	la $a0, ($t0)
	syscall
	
	li $v0, 4			# print space
	la $a0, Space
	syscall
	
	li $v0, 100			# print arg2 in 1s comp
	la $a0, ($t0)
	syscall
	
	li $v0, 4			# print space
	la $a0, Space
	syscall
	
	li $v0, 101			# print arg2 in sm
	la $a0, ($t0)
	syscall
	
	li $v0, 4			# print nl
	la $a0, NewLine
	syscall
	
arg2_part2:
	lw $t0, arg3			# put location of arg2 in t0
	lb $t5, ($t0)			# put 1st char in s1 
	addi $t0, $t0, 1		# advance to next char
	lb $t6, ($t0)			# do dsame for 2-4
	addi $t0, $t0, 1		
	lb $t7, ($t0)			
	addi $t0, $t0, 1		
	lb $t8, ($t0)			 
	
	li $v0, 4			# print arg2
	la $a0, Part1_string
	syscall
	
	li $t0, 0
	move $t0, $t5			# move first letter
	sll $t1, $t6, 8			# move second
	add $t0, $t0, $t1
	sll $t1, $t7, 16		# move 3
	add $t0, $t0, $t1
	sll $t1, $t8, 24		# move 4
	add $t0, $t0, $t1		# move 4
	move $s7, $t0			# store for hamming
	
	li $v0, 35			# print arg2 in bin
	la $a0, ($t0)
	syscall
	
	li $v0, 4			# print space
	la $a0, Space
	syscall
	
	li $v0, 34			# print arg2 in hex
	la $a0, ($t0)
	syscall
	
	li $v0, 4			# print space
	la $a0, Space
	syscall
	
	li $v0, 1			# print arg2 in 2s comp
	la $a0, ($t0)
	syscall
	
	li $v0, 4			# print space
	la $a0, Space
	syscall
	
	li $v0, 100			# print arg2 in 1s comp
	la $a0, ($t0)
	syscall
	
	li $v0, 4			# print space
	la $a0, Space
	syscall
	
	li $v0, 101			# print arg2 in sm
	la $a0, ($t0)
	syscall
	
hammingDistance:
	li $t0, 0			# ham = 0
	xor $t1, $s6, $s7		# val = x or y
	
hamLoop:
	beqz $t1, hamDone		# val = 0
	addi $t0, $t0, 1		# ham++
	addi $t2, $t1, -1		# val-- for and
	and $t1, $t1, $t2		# val &= val -1
	j hamLoop
	
hamDone:
	li $v0, 4			# print nl
	la $a0, NewLine
	syscall
	li $v0, 4			# print hammtext
	la $a0, HammingDist
	syscall
	
	li $v0, 1			# print ham
	la $a0, ($t0)	
	syscall
	j exit

error:
	li $v0, 4			# print error
	la $a0, Err_string
	syscall
	j exit

arg1_R:
	lw $t0, arg2			# put location of arg2 in t0
	beqz $t0, error			# no arg 2
	lw $t0, arg3			# put location of arg3 in t0
	bnez $t0, error			# arg 3
	lw $t0, arg2
	li $t2, 0			# sum = 0
	
r_loop:
	lb $t1, ($t0)			# char at position in t0
	beqz $t1, r_loop_done		# end of string
	blt $t1, '0', r_loop_done	# LESS THAN 0
	bgt $t1, '9', r_loop_done	#greater than 9
	li $t3, 10			# for mult
	mult $t2, $t3
	mflo $t2			# sum = sum*10
	li $t4, '0'		
	sub $t3, $t1, $t4		# char - 0
	add $t2, $t2, $t3		# sum = sum + ^^
	
increment:
	addi $t0, $t0, 1		# increent string
	j r_loop
		
r_loop_done:
	#li $v0, 4			# print p2
	#la $a0, Sum
	#syscall
	#li $v0, 1			# print p2
	#move $a0, $t2
	#syscall
	
	li $v0, 40
	li $a0, 0			# a0 = 0
	move $a1, $t2			# seed
	syscall
	li $t0, 0			# total values
	li $t1, 0			# evens
	li $t2, 0			# odds
	li $t3, 0			# powers of 2
	li $t4, 0 			# mult 2
	li $t5, 0			# mut 4
	li $t6, 0			# mult 8
	
r_loop2:
	blt $a0, 64 testPower		# less than 64
	beq $a0, 64, r_loop2_done
	beq $a0, 128, r_loop2_done
	beq $a0, 256, r_loop2_done
	beq $a0, 512, r_loop2_done
	beq $a0, 1024, r_loop2_done
	
notPower2:
	li $v0, 42
	li $a1, 1024			# uppserbound
	syscall
	
	j r_loop2
	
testPower:
	beq $a0, 1, r_loop2_done
	beq $a0, 2, r_loop2_done
	beq $a0, 4, r_loop2_done
	beq $a0, 8, r_loop2_done
	beq $a0, 16, r_loop2_done
	beq $a0, 32, r_loop2_done	
	j notPower2

r_loop2_done:
	addi $t3, $t3, 1		# was power of 2, add 1

	li $v0, 4			# print
	la $a0, LastVal
	syscall
	
	li $v0, 4			# print nl
	la $a0, NewLine
	syscall
	li $v0, 4			# print
	la $a0, TotalVal
	syscall

	li $v0, 4			# print nl
	la $a0, NewLine
	syscall
	li $v0, 4			# print
	la $a0, Even
	syscall
	
	li $v0, 4			# print nl
	la $a0, NewLine
	syscall
	li $v0, 4			# print
	la $a0, Odd
	syscall

	li $v0, 4			# print nl
	la $a0, NewLine
	syscall
	li $v0, 4			# print
	la $a0, Power2
	syscall
	
	li $v0, 4			# print nl
	la $a0, NewLine
	syscall
	li $v0, 4			# print
	la $a0, Mult2
	syscall
	
	li $v0, 4			# print nl
	la $a0, NewLine
	syscall
	li $v0, 4			# print
	la $a0, Mult4
	syscall
	
	li $v0, 4			# print nl
	la $a0, NewLine
	syscall
	li $v0, 4			# print
	la $a0, Mult8
	syscall
	j exit

exit:
	li $v0, 10
	syscall
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	