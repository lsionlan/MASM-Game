.data
	startString BYTE "Press w key to start...", 0
	continueString BYTE "you pressed w!! Game will continue.", 0
	failString BYTE "you pressed other key, you such a asshole!!", 0
.code
start PROC
	call	ClrScr   ; Clean the screen and start the game.

	mov 	edx, OFFSET[startString] ; Tell user press w to start.
	call 	WriteString
	call 	Crlf

RETRY:
	call 	ReadChar  ; If user press w then continue.
	cmp 	al, 'w'
	je		CONTINUE
FAIL:
	mov 	edx, OFFSET[failString] ; Tell user have to retry.
	call 	WriteString
	call 	Crlf
	jmp 	RETRY
CONTINUE:
	mov 	edx, OFFSET[continueString]     ; Tell user the game will continue.
	call 	WriteString
	call    Crlf
	
	ret
start ENDP
