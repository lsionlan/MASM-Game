TITLE start
;INCLUDE score.asm
.data
	space     		BYTE "             ",0
	space2     		BYTE "                ",0
	cStr		 	BYTE "Press spacebar to continue", 0	
	readynumber1 	BYTE "  3  ", 0
	readynumber2 	BYTE "  2  ", 0
	readynumber3 	BYTE "  1  ", 0
	goStr			BYTE "GO!!!", 0
	exStr1			BYTE "Instructions:",0
	exStr2			BYTE "Please use the spacebar to jump",0
	opt1			BYTE "Start",0
	opt2			BYTE "Rank",0
	opt3			BYTE "Instructions",0
.code
start PROC
	call	ClrScr
STARTACREEN:
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	mov 	edx, OFFSET[space2] 
	call 	WriteString
	call 	WriteString
	mov 	edx, OFFSET opt1
	call 	WriteString
	call 	Crlf
	mov 	edx, OFFSET[space2] 
	call 	WriteString
	call 	WriteString
	mov 	edx, OFFSET opt2
	call 	WriteString
	call 	Crlf
	mov 	edx, OFFSET[space2] 
	call 	WriteString
	call 	WriteString
	mov 	edx, OFFSET opt3
	call 	WriteString
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	mov 	edx, OFFSET[space] 
	call 	WriteString
	call 	WriteString
	mov 	edx, OFFSET[cStr] ; Tell user press spacebar to start.
	call 	WriteString
	call 	Crlf
RETRY:
	call 	ReadChar  ; If user press spacebar then continue.
	cmp 	al, ' '
	je		EX
FAIL1:
	jmp 	RETRY
EX:
	call	ClrScr
	mov 	edx, OFFSET[exStr1]     ; rule ex
	call 	WriteString
	call 	Crlf
	mov 	edx, OFFSET[exStr2]     
	call 	WriteString
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	mov 	edx, OFFSET[space] 
	call 	WriteString
	call 	WriteString
	mov 	edx, OFFSET[cStr] ; Tell user press spacebar to start.
	call 	WriteString
	call 	ReadChar  ; If user press spacebar then continue.
	cmp 	al, ' '
	je		READY
FAIL2:
	jmp 	EX
READY:
	call    ClrScr
	mov		eax, 1000
	call	Delay	

	mov 	edx, OFFSET[readynumber1]	
	call 	WriteString	
	mov		eax, 1000
	call	Delay
	call    ClrScr

	mov 	edx, OFFSET[readynumber2]
	call 	WriteString
	mov		eax, 1000
	call	Delay
	call    ClrScr

	mov 	edx, OFFSET[readynumber3]
	call 	WriteString
	mov		eax, 1000
	call	Delay
	call    ClrScr

	mov 	edx, OFFSET[goStr]
	call 	WriteString
	mov		eax, 1000
	call	Delay
	call    ClrScr
start ENDP
