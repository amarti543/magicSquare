.data




.text
.align 4
.global main		
.type main, %function

@r4 = user input number
@r5 = input squared 
@r6 = array[0]
@r7 = counter at various parts of program
@r8 = row 
@r10 = column


@Program starts by creating the base address of the array and storing it in r6.
@Program then calls getInput to get an odd number from the user and stores it in r4.
@Program then calls magicSqaure to allocate the space needed for the array of numbers, fills them with 0 to denote empty array elements, and finally implements the algorithm to fill the array with the numbers in the correct order.
@Finally, program calls the printSquare function to display the elements as a 2d array in order, output formatted as [%3d]


main:
	push {fp,lr}	
	add fp,sp,#4
	


	bl getInput

	bl magicSquare



	bl printSquare


done: 
	@freeing memory
	mov r0,r6
	bl free


	add sp,sp,#8
	sub sp,fp,#4
	pop {fp,pc}

