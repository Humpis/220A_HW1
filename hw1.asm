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
	lb $t1, ($t0)  			# put char from arg1 in t1
	addi $t0, $t0, 1		# increment arg1
	lb $t2, 0($t0)			# put second char from arg1 in t2
	beqz $t2, arg1is1Char
	li $v0, 4			# print error
	la $a0, Err_string
	syscall
	j exit
	
arg1is1Char:


exit:
	li $v0, 10
	syscall
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	