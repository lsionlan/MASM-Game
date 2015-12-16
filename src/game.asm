.data
	
	upString BYTE "  up  ", 0
	downString BYTE "  down  ", 0
	leftString BYTE "  left  ", 0
	rightString BYTE "  right  ", 0

.code
game PROC
LookForKey:
	mov		eax, 100
	call	Delay
	mov 	eax, 98
	call 	WriteChar
	call 	ReadKey
	jz		LookForKey
	

	cmp		edx, 1572902
	je 		UP
	cmp		edx, 1572901
	je 		LEFT
	cmp 	edx, 1572904
	je 		DOWN
	cmp		edx, 1572903
	je		RIGHT
	cmp 	edx, VK_ESCAPE
	jne 	LookForKey
UP:
	mov 	edx, OFFSET[upString]
	call 	WriteString
	jmp 	LookForKey
DOWN:
	mov 	edx, OFFSET[downString]
	call 	WriteString
	jmp 	LookForKey
LEFT:
	mov 	edx, OFFSET[leftString]
	call 	WriteString
	jmp 	LookForKey
RIGHT:
	mov 	edx, OFFSET[rightString]
	call 	WriteString
	jmp 	LookForKey

	exit
game ENDP