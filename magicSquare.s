@architecture
.cpu cortex-a53
.fpu neon-fp-armv8

.data
.align 8


.text
.align 4
.global magicSquare		
.type	magicSquare, %function

magicSquare:
	push {fp,lr}
	add fp,sp,#4 
	sub sp,sp,#100

allocateSpace:
	mov r0,r4	@calculating number of spaces needed by squaring input
	mov r1,r4	@putting input into r1 for multiply call
	bl multiply


	mov r5,r0	@store squared input in designated register r5


	lsl r0,r5,#2	@r0= input^2 *4
	bl malloc			@allocating memory

	mov r6,r0

	
	mov r0,#0	@putting 0 into r0, to be used as counter
	sub r8,r4,#1	@r8 = input - 1(row starting position)
	lsr r9,r4,#1	@r9 = input/2(column starting position)
	
	fillZero:
	cmp r0,r5	@checking if counter has reached input squared
	beq initializeK	@if so, move on to next step

	mov r1,#0	@r1 = 0
	lsl r2,r0,#2	@r2 = counter*4 (offset)
	add r2,r6,r2	@r2 = base + offset
	str r1,[r2]	@storing 0 in address of r2

	add r0,r0,#1	@add 1 to counter
	b fillZero	@back to loop start


initializeK:
	mov r7,#0	@put 0 in r7(k)

fillNumbers:
	add r7,r7,#1	@add 1 to counter(k)
	cmp r7,r5	
	bgt done	@if k > input^2, done

	mov r0,r8	@r0= row
	mov r1,r4	@r1= input
	
	bl multiply	@returns row*input
		
	lsl r0,r0,#2	@multiplying row*input by 4 to get total offset for row
	lsl r1,r9,#2	@multiplying column by 4 to get total offset for column
		
	add r0,r0,r1	@calculating total offset
	add r0,r0,r6	@r0 = base array address + offset

	str r7,[r0]	@storing k in current array position



	mov r0,r8	@storing pre-increment row value
	mov r1,r9	@storing pre-increment column value

	add r8,r8,#1	@adding 1 to row
	cmp r8,r4	@checking if row has reached input
	bne checkColumn

	mov r8,#0	@make row = 0 if it has reached input



checkColumn:	
	add r9,r9,#1	@adding 1 to column
	cmp r9,r4	@checking if column has reached input
	bne checkEmpty	@if not, move on to check if next space is empty
	
	mov r9,#0	@if column reached input, set it to 0

checkEmpty:
	push {r0-r1}	@save pre-increment values before function call
	mov r0,r8	@put new row value into r0
	mov r1,r4	@put input value into r1
	bl multiply	@multiply them
	pop {r2-r3}	@restore pre-increment values after function call

	lsl r0,r0,#2	@multiply result by 4
	lsl r1,r9,#2	@multiply new column by 4
	add r0,r1,r0	@add both values to get offset
	add r0,r0,r6	@put base address of array + offset into r0
	
	ldr r0,[r0]	@loading to check the value in address
	mov r1,#0	@storing 0 in r1 for comparisson
	cmp r0,r1	
	beq fillNumbers	@if array position holds 0(empty), go back to start of loop

	mov r8,r2	@if not empty, restore pre-increment row and column values
	mov r9,r3
	cmp r8,r1	@check if pre-increment row value is 0
	bne subRow	@if not 0, move on 

	sub r8,r4,#1	@if row == 0 , make it equal to input-1
	b fillNumbers	@back to start of loop
	
subRow:
	sub r8,r8,#1	@r8 = pre-increment row-1
	b fillNumbers	@back o start of loop

done:
	add sp,sp,#100
	sub sp,fp,#4
	pop {fp,pc}


