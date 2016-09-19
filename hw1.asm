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
	Part2_string: .asciiz "Part 2: "
	Space: .asciiz " "
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
	
	sll $t0, $s1, 24		# move first letter
	sll $t1, $s2, 16		# move second
	add $t0, $t0, $t1
	sll $t1, $s3, 8			# move 3
	add $t0, $t0, $t1
	add $t0, $t0, $s4		# move 4
	
	li $v0, 35			# print arg2 in bin
	la $a0, ($t0)
	syscall
	
	li $v0, 4			# print space
	la $a0, Space
	syscall
	
	j exit

error:
	li $v0, 4			# print error
	la $a0, Err_string
	syscall
	j exit

arg1_R:
	li $v0, 4			# print p2
	la $a0, Part2_string
	syscall
	j exit

exit:
	li $v0, 10
	syscall
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	