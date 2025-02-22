@architecture
.cpu cortex-a53
.fpu neon-fp-armv8

.data


.text
.align 4
.global multiply
.type multiply, %function

	
multiply:
	push {fp,lr}	
	add fp,sp,#4	


@first checking if any of the parameters are 0
	mov r2,#0
	cmp r1,r2
	beq zero
	cmp r0,r2
	beq zero



	mov r2,#1	@counter	
	mov r3,r0	@putting original multiplicand value in r3


add:
	cmp r1,r2	@compare counter to multiplier
	beq done	@if equal, done
	
	
	add r0,r3,r0	@add multiplicand to its self
	add r2,r2,#1	@increment counter

	b add					@branch back to add

zero:
	mov r0,#0
	b done
	
done: 
	sub sp,fp,#4
	pop {fp,pc}


