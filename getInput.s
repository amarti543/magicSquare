@architecture
.cpu cortex-a53
.fpu neon-fp-armv8

.data

.align 2
prompt:
	.asciz "Enter an odd number: "


input: .asciz "%d"

.align 4
number: .word 0

.text
.align 4
.global getInput		
.type getInput, %function



getInput:
	push {fp,lr}			@pushing frame pointer
	add fp,sp,#4			@storing current sp+4 in fp,sp stays the same at 0

loop:
	ldr r0,=prompt			@loading prompt string into r0 for printf
	bl printf			@calling printf


	ldr r1,=number			@loading number into r1
	ldr r0,=input  			@loading input into r0

	bl scanf			@calling scanf
		
	ldr r1,=number	@loading first digit address into r1 
	ldr r0,[r1]			@loading value of address in r1 into r0
	
	mov r1,#2			@storing 2 in r1 for comparison
	
	cmp r0,r1		
	ble loop			@if input is less than or equal to 2, get input again 
	

checkOdd:
	push {r0}			@pushing input before function call
	bl modulo			@calling modulo	
	pop {r2}			@popping input into r2 post modulo call
	mov r1,#0			@moving 0 into r1 for comparison with return value from modulo
	cmp r0,r1			
	beq loop			@if mod returns 0, number is even, get input again

	mov r4,r2			@if mod returns any number other than 0, store input into designated register r4

	done:
	sub sp,fp,#4 		@ending program
	pop {fp,pc}




