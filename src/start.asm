TITLE start
INCLUDE rank.asm
.data
	textStr			BYTE "Foreword:",0
	textStr1		BYTE "Enter is equal to enter the spacebar twice.",0
	textStr2		BYTE "Please enter the 's' to choose the next option.",0
	entgaStr		BYTE "Please enter the spacebar to continue.",0
	space     		BYTE "              ",0
	space2     		BYTE "                ",0
	cStr		 	BYTE "continue ( spacebar )", 0	
	readynumber1 		BYTE "  3  ", 0
	readynumber2 		BYTE "  2  ", 0
	readynumber3 		BYTE "  1  ", 0
	goStr			BYTE "GO!!!", 0
	exStr1			BYTE "Instructions:",0
	exStr2			BYTE "Please use the spacebar to jump.",0
	opt1			BYTE "Start",0
	opt2			BYTE "Rank",0
	opt3			BYTE "Instructions",0
	Bstr			BYTE "Back ( b )",0	
.code
start PROC	
STARTSCREEN:
	call	ClrScr	
	mov	edx, OFFSET[textStr]
	call 	WriteString
	call 	Crlf
	mov	edx, OFFSET[textStr1]
	call 	WriteString	
	call 	Crlf
	mov	edx, OFFSET[textStr2]
	call 	WriteString	
	call 	Crlf
	mov	edx, OFFSET[entgaStr]
	call 	WriteString
	call 	ReadChar
	cmp 	al, ' '
	je	GAMECH
TES:
	jmp 	STARTSCREEN
GAMECH:
	call	ClrScr
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
	mov 	edx, OFFSET[space2] 		;G
	call 	WriteString			;A
	call 	WriteString			;M
	mov	eax,white+(blue*16)		;E
	call	SetTextColor			;S
	mov 	edx, OFFSET opt1		;T
	call 	WriteString			;A
	mov	eax,white+(black*16)		;R
	call	SetTextColor			;T
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
	call 	ReadChar
	cmp 	al, 's'
	je	L_RANK
TES1:
	call 	ReadChar  
	cmp 	al, ' '
	je	READY
CHE1:
	jmp	GAMECH
L_RANK:
	call	ClrScr
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
	mov 	edx, OFFSET[space2] 		;
	call 	WriteString			;
	call 	WriteString			;
	mov 	edx, OFFSET opt1		;
	call 	WriteString			;
	call 	Crlf				;
	mov 	edx, OFFSET[space2] 		;
	call 	WriteString			;
	call 	WriteString			;
	mov	eax,white+(blue*16)		;
	call	SetTextColor			;
	mov 	edx, OFFSET opt2		;
	call 	WriteString			;
	call 	Crlf				;
	mov	eax,white+(black*16)		;
	call	SetTextColor
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
	call 	ReadChar  
	cmp 	al, 's'
	jmp	INST
TES2:
	call 	ReadChar 
	cmp 	al, ' '
	call	showrank
CHE2:
	jmp	L_RANK
INST:
	call	ClrScr
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
	mov 	edx, OFFSET[space2] 		;
	call 	WriteString			;
	call 	WriteString			;
	mov 	edx, OFFSET opt1		;
	call 	WriteString			;
	call 	Crlf				;
	mov 	edx, OFFSET[space2] 		;
	call 	WriteString			;
	call 	WriteString			;					
	mov 	edx, OFFSET opt2		;
	call 	WriteString			;
	call 	Crlf				;	
	mov 	edx, OFFSET[space2] 
	call 	WriteString
	call 	WriteString
	mov	eax,white+(blue*16)			
	call	SetTextColor
	mov 	edx, OFFSET opt3
	call 	WriteString
	mov	eax,white+(black*16)		
	call	SetTextColor	
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
	call 	ReadChar  
	cmp 	al, 's'
	je	GAMECH
TES3:
	call 	ReadChar 
	cmp 	al, ' '
	je	EX
CHE3:
	jmp	INST
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
	mov 	edx, OFFSET[bStr] ; Tell user press spacebar to start.
	call 	WriteString
	call 	ReadChar  ; If user press spacebar then continue.
	cmp 	al, 'b'
	je	GAMECH
FAIL2:	
	jmp 	EX
READY:
	call    ClrScr
	mov	eax, 1000
	call	Delay	

	mov 	edx, OFFSET[readynumber1]	
	call 	WriteString	
	mov	eax, 1000
	call	Delay
	call    ClrScr

	mov 	edx, OFFSET[readynumber2]
	call 	WriteString
	mov	eax, 1000
	call	Delay
	call    ClrScr

	mov 	edx, OFFSET[readynumber3]
	call 	WriteString
	mov	eax, 1000
	call	Delay
	call    ClrScr

	mov 	edx, OFFSET[goStr]
	call 	WriteString
	mov	eax, 1000
	call	Delay
	call    ClrScr
start ENDP
