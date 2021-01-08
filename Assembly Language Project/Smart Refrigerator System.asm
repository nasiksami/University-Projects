.data
welcomeMsg:		.asciiz "<---Welcome to Refrigerator System--->\nPlease Login!!\n"
userNMsg:		.asciiz "Enter your username: "
passMsg:		.asciiz "Enter your password: "
wrongMsg:		.asciiz "Please enter correct username and password!!!\n"
menu:			.asciiz "Choose an option:\n\t1: Add Items\n\t2: Remove Items\n\t3: Do nothing\n"
wrongOpt:		.asciiz "Invalid option. Choose valid one!!!\n"
howManyAdd:		.asciiz "How many items you want to add? "
howManyRem:		.asciiz "How many items you want to remove? "
tempMsg:		.asciiz "Enter temperature: "
weightMsg:		.asciiz "\nEnter weight: "
user1:			.asciiz "Zian"
user2:			.asciiz "Sami"
user3:			.asciiz "Sariful"
user4:			.asciiz "Jaki"
cantRemove:		.asciiz "Refrigerator has no item. So, you can't remove items!!!\n"
wrongWeight:		.asciiz "Weight is inaccurate!!\n"
weightOverMsg:		.asciiz "Weight is overloaded\n"
tempOverMsg:		.asciiz "Temperature is unbalanced\n"
lessAlert:		.asciiz "Your inventory is running out of items. Please refill soon\n"
greaterAlert:		.asciiz "The inventory is already full. You can not add more items now\n"
itemsAdded:		.asciiz " items are added."
itemsRemoved:		.asciiz " items are removed."
totalItem:		.asciiz "Total items in refrigerator are: "
tempIs:			.asciiz "\nTemperature is: "
weightIs:		.asciiz "\nWeight is: "
storedItem:		.word	0
password:		.word	54321
userName:		.space	10
	
.text
# display welcome message
la	$a0, welcomeMsg
jal	displayNotification
main:
# display username message
la	$a0, userNMsg
jal	displayNotification

# read username from user
la	$a0, userName
li	$a1, 11			# 10 charcaters can be read from user
jal	readStrInput

# print password message
la	$a0, passMsg
jal	displayNotification

# read password from user
jal	readIntInput
move	$t0, $v0		# move password into t0
checkUserName:
	la	$a0, user1
	la	$a1, userName
	jal	strCmp		# check username and user1 are equal or not
	beqz	$v0, checkPassword	# if v0 == 0 goto checkPassword
	
	la	$a0, user2
	la	$a1, userName
	jal	strCmp		# check username and user2 are equal or not
	beqz	$v0, checkPassword	# if v0 == 0 goto checkPassword
	
	la	$a0, user3
	la	$a1, userName
	jal	strCmp		# check username and user2 are equal or not
	beqz	$v0, checkPassword	# if v0 == 0 goto checkPassword
	
	la	$a0, user4
	la	$a1, userName
	jal	strCmp		# check username and user2 are equal or not
	beqz	$v0, checkPassword	# if v0 == 0 goto checkPassword
	j	inValid			# else jump on inValid
checkPassword:
	lw	$t1, password		# load password into t1
	bne	$t0, $t1, inValid	# if t0 != password goto inValid
DisplayMenu:
	# display menu on console
	la	$a0, menu
	jal	displayNotification
	
	# read option from user
	jal	readIntInput
	move	$t0, $v0		# move choice into t0
	beq	$t0, 1, goAdd		# if choice == 1 goto goAdd
	beq	$t0, 2, goRemove	# else if choice == 2 goto goRemove
	beq	$t0, 3, printValue	# else if choice == 3 goto printValue
	la	$a0, wrongOpt		# else print wrong option message
	jal	displayNotification
	j	DisplayMenu			# jump on DisplayMenu
goAdd:
	# print how maany add message 
	la	$a0, howManyAdd		
	jal	displayNotification
	# read added items from user
	jal	readIntInput
	move	$t0, $v0		# move items quantity into t0
	# integer value
	move	$a0, $t0		
	jal	displayIntegerValue
	
	# print items added string
	la	$a0, itemsAdded
	jal	displayNotification
	
	
	lw	$t1, storedItem		# stored item
	add	$t1, $t1, $t0		# present item = store item + added item
	sw	$t1, storedItem		# update storedItem
	blt	$t1, 3, runningOut	# if present item < 3 goto runningOut
	bgt	$t1, 20, overLoaded	# else if present item > 20 goto overLoaded
	j	goToWeight		# else jump on goToWeight
	runningOut:
		# print runningOut message
		la	$a0, lessAlert
		jal	displayNotification
		j	printValue	# jump on printValue
	overLoaded:
		# print overLoaded message
		la	$a0, greaterAlert
		jal	displayNotification
		j	printValue	# jump on printValue
goToWeight:
	# print enter weight message
	la	$a0, weightMsg
	jal	displayNotification
	# read weight from user
	jal	readIntInput
	move	$t2, $v0		# move weight into t2
	blez	$t2, invalidWeight  
	bge	$t2, 50, weightAlert	# if weight >= 50 goto weightAlert
	j	gotoTemperature		# else jump on gotoTemperature
	
	weightAlert:
		# print weight overloaded message
		la	$a0, weightOverMsg
		jal	displayNotification
		j	printValue	# jump on printValue
	invalidWeight:
		la	$a0, wrongWeight
		jal	displayNotification
		j	goToWeight
		
gotoTemperature:
	# print enter temperature message
	la	$a0, tempMsg		
	jal	displayNotification
	# read temperature from user
	jal	readIntInput	
	move	$t3, $v0		# move temperature into t3
	blt	$t3, -10, tempAlert	# if temperature < -10 goto tempAlert
	bgt	$t3, 10, tempAlert	# else if temperature > 10 goto tempAlert 
	j	DisplayMenu			# jump on DisplayMenu
	
	tempAlert:
		# print temperature over loaded message
		la	$a0, tempOverMsg
		jal	displayNotification
		j	printValue	# jump on printValue
	
goRemove:
	# print how many remove message
	la	$a0, howManyRem
	jal	displayNotification
	# read removed items from user
	jal	readIntInput
	move	$t0, $v0		# move removed items into t0
	lw	$t1, storedItem		# stored item
	beqz	$t1, cantBeRemove
	# print removed items
	move	$a0, $t0
	jal	displayIntegerValue
	# print items removed message
	la	$a0, itemsRemoved
	jal	displayNotification
	
	lw	$t1, storedItem		# stored item
	sub	$t1, $t1, $t0		# present item = store item - added item
	sw	$t1, storedItem		# update store item
	blt	$t1, 3, runningOut	# if t1 < 3 goto runningOut
	bgt	$t1, 20, overLoaded	# else if t1 > 20 goto overLoaded
	j	goToWeight		# jump on gotoWeight
cantBeRemove:
	# print can't remove message
	la	$a0, cantRemove
	jal	displayNotification
	j	DisplayMenu
	
# if username or password wrong then this block of code execute
inValid:
	# print invalid message
	la	$a0, wrongMsg
	jal	displayNotification
	j	main	# jump on main

printValue:
	# print total items message
	la	$a0, totalItem
	jal	displayNotification
	# print total items value
	lw	$a0, storedItem
	jal	displayIntegerValue
	
	# print weight message
	la	$a0, weightIs
	jal	displayNotification
	# print weight value
	move	$a0, $t2
	jal	displayIntegerValue
	
	# print temperature message
	la	$a0, tempIs
	jal	displayNotification
	# print temperature value
	move	$a0, $t3
	jal	displayIntegerValue		
# End of program
exit:
	li	$v0, 10
	syscall


# this function display a string on console
displayNotification:
	li	$v0, 4
	syscall
	jr	$ra
	
# this function read integer value from user
readIntInput:
	li	$v0, 5
	syscall	
	jr	$ra

# this function read string value from user
readStrInput:
	li	$v0, 8
	syscall	
	jr	$ra
	
# this function print integer value on console
displayIntegerValue:
	li	$v0, 1
	syscall	
	jr	$ra

# this function compare two string if both strings are equal then $v0 = 0	
strCmp:
	add	$s0,$zero,$zero 	# s0 = 0
	add	$s1,$zero,$a0 		# s1 = first string address
	add	$s2,$zero,$a1 		# s2 = second string address
	loop:
		lb	$s3,0($s1) 		# load a byte from string 1
		lb	$s4,0($s2) 		# load a byte from string 2
		beq	$s3, 10, returnStrCmp
		beqz	$s3, returnStrCmp
		bne	$s3, $s4, setMinusOne 		
		li	$v0, 0
		j	nextChars
	setMinusOne:
		li	$v0, -1
	nextChars:
		addi	$s1,$s1,1 		# s1 points to the next byte of str1
		addi	$s2,$s2,1
		j	loop
returnStrCmp:
	jr	$ra
