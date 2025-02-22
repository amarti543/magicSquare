@architecture
.cpu cortex-a53
.fpu neon-fp-armv8

.data

.align 2
printFormat: .asciz "[%3d]"
.align 2
endLine: .asciz "\n"


.text
.align 8
.global printSquare		
.type	printSquare, %function

printSquare:
	push {fp,lr}
	add fp,sp,#4 



	mov r7,#0	@r7 = counter
	mov r8,#0	@resetting r8
	
printLoop:
	cmp r7,r5
	beq done
	lsl r8,r7,#2	@r8 = counter*4
	add r8,r6,r8	@r8 = base + offset


	ldr r0,=printFormat
	ldr r1,[r8]
	bl printf

	add r7,r7,#1	@counter++
	cmp r7,r4
	blt printLoop

	mov r0,r7
	mov r1,r4
	bl modulo
	mov r1,#0
	cmp r0,r1
	bne printLoop

	ldr r0,=endLine
	bl printf
	b printLoop

done:
	sub sp,fp,#4
	pop {fp,pc}


