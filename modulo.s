@architecture
.cpu cortex-a53
.fpu neon-fp-armv8

.data


.text
.align 4
.global modulo
.type modulo, %function

modulo:
	push {fp,lr}	
	add fp,sp,#4
	sub sp,sp,#8
	

	check:
	cmp r0,r1			@checking if dividend is smaller than divisor
	blt done			@go to done once dividend has reached value smaller than divisor

	subtract:

	sub r0,r0,r1	@subtracting dividend by divisor
	
	b check				@back to check


	done: 
	add sp,sp,#8
	sub sp,fp,#4
	pop {fp,pc}


