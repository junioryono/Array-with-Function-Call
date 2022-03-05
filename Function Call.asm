.data
	# HEADER
	intro1: .asciiz "=======================================================================\n"
	intro2: .asciiz "Program Description:\tLab Function Call\n"
	intro3: .asciiz "Author:\t\t\tAmer Yono\n"
	intro4: .asciiz "Creation Date:\t\t10/07/2021\n"
	newline: .asciiz "\n"
	
	str1: .asciiz "Enter a number between 2 and 11: "
	str2: .asciiz "Enter a number value: "
	str3: .asciiz "Input is not between 2 and 11!\n"
	str4: .asciiz "The sum of all the elements in the array is: "
	array: .word 0
	
.text
	# HEADER
	li $v0, 4
	la $a0, intro1
	syscall
	
	li $v0, 4
	la $a0, intro2
	syscall
	
	li $v0, 4
	la $a0, intro3
	syscall
	
	li $v0, 4
	la $a0, intro4
	syscall
	
	li $v0, 4
	la $a0, intro1
	syscall
	
main: # LAB
	li $s0, 2 # Value to check for
	li $s1, 11 # Value to check for
	
	# Ask for input
	li $v0, 4
	la $a0, str1
	syscall
	
	# Get input
	li $v0, 5
	syscall
	
	add $s2, $v0, 0 # Store user value inside $s2
	
	# Check for errors
	ble $s2, $s0, error
	bge $s2, $s1, error
	
	la $s3, array # Load array
	
	# Start function with number of elements parameter
	add $a0, $s2, $0
	add $a1, $s3, $0
	jal startArray
	
	la $s3, array # Load array
	
	# Start function with pointer of array
	add $a1, $s3, $0
	jal addElement
	add $t3, $v0, $0 # Store return of function inside $t3
	
	# End output string
	li $v0, 4
	la $a0, str4
	syscall
	
	# End output number value
	li $v0, 1
	add $a0, $t3, $0
	syscall
	
	# Terminate
	li $v0, 10
	syscall
	
error:
	li $v0, 4
	la $a0, str3
	syscall
	j main
	
startArray:
	add $t0, $a0, $0 # Store parameter to $t0
	
fillArray:
	# Ask for user input into array element
	li $v0, 4
	la $a0, str2
	syscall
	
	# Get user input into array element
	li $v0, 5
	syscall
	
	sw $v0, 0($a1) # Store value into array
	
	# Add to counters
	addi $a1, $a1, 4
	addi $t1, $t1, 1
	
	bne $t1, $t0, fillArray # Check if finished
	
	jr $ra # If finished, return
	
addElement: # Add elements together
	lw $t2, 0($a1) # Load value from array
	
	# Add to total number
	add $t3, $t3, $t2
	
	# Add to counters
	addi $a1, $a1, 4
	addi $t4, $t4, 1
	
	# Check if finished
	bne $t4, $t0, addElement
	
	# If finished, return
	addi $v0, $t3, 0
	jr $ra 
