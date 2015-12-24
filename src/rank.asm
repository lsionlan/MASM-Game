INCLUDE Irvine32.inc
INCLUDE utils.asm

; Max character read into buffer string.
BUF_SIZE EQU 512

rank STRUCT
	player BYTE 30 DUP(32), 0
	score BYTE "00000", 0
rank ENDS

.data
	hFile 		DWORD ?
	buffer 		BYTE BUF_SIZE DUP(32), 0
	rankFont 	BYTE "rankFont.txt", 0
	rankFile 	BYTE "score.txt", 0
	rank1 		rank <>
	rank2 		rank <>
	rank3 		rank <>
	rank4 		rank <>
	rank5 		rank <>
	newrank		rank <>
	writeError  BYTE "write file error", 0
	readError 	BYTE "read file error", 0
	promptPlayer BYTE "Enter your name: ", 0
	promptScore BYTE "Enter your score: ", 0
	promptback 	BYTE "b: back to menu", 0
	first 		BYTE "                 1. ", 0
	second 		BYTE "                 2. ", 0
	third		BYTE "                 3. ", 0
	forth 		BYTE "                 4. ", 0
	fifth		BYTE "                 5. ", 0

.code

; -----------------------------------------------
cleanString PROC
; al -> character
; ecx -> string size
; edx -> string head
; -----------------------------------------------
START:
	mov 	BYTE PTR [edx], al
	inc 	edx
	loop 	START
	ret
cleanString ENDP

; -----------------------------------------------
strlen PROC
; edx -> string head
; return eax
; -----------------------------------------------
	mov 	eax, 0
START:
	mov 	bl, BYTE PTR [edx]
	cmp 	bl, 0
	je		DONE
	inc 	edx
	inc 	eax
	jmp 	START
DONE:
	ret
strlen ENDP

; -----------------------------------------------
myWrite PROC
; edx -> string head
; ecx -> strlen
; -----------------------------------------------
	mov 	edi, edx
	call 	WriteString
	mov 	edx, edi
	call 	strlen
	mov 	ecx, 36
	sub 	ecx, eax
	
START:
	mov 	al, 32
	call 	WriteChar
	loop 	START
	ret
myWrite ENDP

; -----------------------------------------------
compareString PROC
; ecx -> strlen
; esi -> str1
; edi -> str2
; 
; Return eax = 1 means greater, 0 means equals, -1 means less than.
; -----------------------------------------------
L1:
	mov 	al, [esi]
	mov 	bl, [edi]
	sub 	al, bl
	
	inc 	esi
	inc 	edi
	cmp 	al, 0
	jg		GREATER
	cmp 	al, 0
	jl		LESS
	loop 	L1
EQUAL:
	mov 	eax, 0
	ret
GREATER:
	mov 	eax, 1
	ret
LESS:
	mov 	eax, -1
	ret
compareString ENDP

; -----------------------------------------------
swapString PROC
; esi -> str1
; edi -> str2
; ecx -> strlen;
; -----------------------------------------------
	mov		edx, 0
L1:
	mov 	al, [esi+edx]
	
	mov 	bl, [edi+edx]
	mov 	[esi+edx], bl
	
	mov 	[edi+edx], al
	inc 	edx
	loop 	L1
	ret
swapString ENDP

; -----------------------------------------------
moveString PROC
; esi -> source
; edi -> destination
; ecx -> string length
; -----------------------------------------------
	mov 	edx, 0
L1:
	mov 	al, [esi+edx]
	mov 	[edi+edx], al
	inc 	edx
	loop 	L1
	ret
moveString ENDP

; -----------------------------------------------
sort PROC
; -----------------------------------------------
	mov 	ecx, 5
	mov 	esi, OFFSET newrank.score
	mov 	edi, OFFSET rank5.score
	call 	compareString
	
	cmp		eax, 0
	jge		L1
	jmp		OVER
L1:
	mov 	ecx, 5
	mov 	esi, OFFSET newrank.score
	mov 	edi, OFFSET rank5.score
	call 	swapString
	mov 	ecx, 30
	mov 	esi, OFFSET newrank.player
	mov 	edi, OFFSET rank5.player
	call 	swapString

	mov 	ecx, 5
	mov 	esi, OFFSET rank5.score
	mov 	edi, OFFSET rank4.score
	call 	compareString
	
	cmp		eax, 0
	jge		L2
	jmp		OVER
L2:
	mov 	ecx, 5
	mov 	esi, OFFSET rank5.score
	mov 	edi, OFFSET rank4.score
	call 	swapString
	mov 	ecx, 30
	mov 	esi, OFFSET rank5.player
	mov 	edi, OFFSET rank4.player
	call 	swapString

	mov 	ecx, 5
	mov 	esi, OFFSET rank4.score
	mov 	edi, OFFSET rank3.score
	call 	compareString
	
	cmp		eax, 0
	jge		L3
	jmp		OVER
L3:
	mov 	ecx, 5
	mov 	esi, OFFSET rank4.score
	mov 	edi, OFFSET rank3.score
	call 	swapString
	mov 	ecx, 30
	mov 	esi, OFFSET rank4.player
	mov 	edi, OFFSET rank3.player
	call 	swapString

	mov 	ecx, 5
	mov 	esi, OFFSET rank3.score
	mov 	edi, OFFSET rank2.score
	call 	compareString
	
	cmp		eax, 0
	jge		L4
	jmp		OVER
L4:
	mov 	ecx, 5
	mov 	esi, OFFSET rank3.score
	mov 	edi, OFFSET rank2.score
	call 	swapString
	mov 	ecx, 30
	mov 	esi, OFFSET rank3.player
	mov 	edi, OFFSET rank2.player
	call 	swapString

	mov 	ecx, 5
	mov 	esi, OFFSET rank2.score
	mov 	edi, OFFSET rank1.score
	call 	compareString
	
	cmp		eax, 0
	jge		L5
	jmp		OVER
L5:
	mov 	ecx, 5
	mov 	esi, OFFSET rank2.score
	mov 	edi, OFFSET rank1.score
	call 	swapString
	mov 	ecx, 30
	mov 	esi, OFFSET rank2.player
	mov 	edi, OFFSET rank1.player
	call 	swapString
OVER:
	ret
sort ENDP

; -----------------------------------------------
Read PROC
; To use this read function you have to:
; edx -> filename
; edi -> buffer
; -----------------------------------------------
	call	OpenInputFile
	cmp     eax, INVALID_HANDLE_VALUE
	je      file_error
	mov     hFile, eax
	
	mov		eax, hFile
	mov 	edx, edi
	mov     ecx, BUF_SIZE
	call    ReadFromFile
	jc      FILE_ERROR
	;mov     bytesRead, eax
	
	mov 	eax, hFile
	call 	CloseFile
	ret
FILE_ERROR:
	mov 	edx, OFFSET readError
	call 	WriteString
	call 	Crlf
	mov 	eax, hFile
	call 	CloseFile
	ret
Read ENDP

; --------------------------------------------------
write PROC
; --------------------------------------------------
; Get file descriptor.
	mov 	edx, OFFSET rankFile
	call 	CreateOutputFile
	;cmp 	eax, INVALID_HANDLE_VALUE
	jc 		FILE_ERROR
	mov 	hFile, eax

	mov 	eax, hFile
	mov 	edx, OFFSET buffer
	mov 	ecx, BUF_SIZE
	call 	WriteToFile
	; mov 	bytesWritten, eax
	mov 	eax, hFile
	call 	CloseFile

FILE_ERROR:
	;mov 	edx, OFFSET writeError
	;call 	WriteString
	;call 	Crlf
	mov 	eax, hFile
	call 	CloseFile
	ret
write ENDP

; -----------------------------------------------
rankIntoBuffer PROC
; -----------------------------------------------
	mov 	eax, 32
	mov 	ecx, BUF_SIZE
	mov 	edx, OFFSET buffer
	call  	cleanString

	mov 	esi, OFFSET rank1.player
	mov 	edi, OFFSET buffer
	mov 	ecx, 30
	call 	moveString
	
	mov 	esi, OFFSET rank1.score
	mov 	edi, OFFSET buffer+30
	mov 	ecx, 5
	call 	moveString
	
	mov 	esi, OFFSET rank2.player
	mov 	edi, OFFSET buffer+35
	mov 	ecx, 30
	call 	moveString
	
	mov 	esi, OFFSET rank2.score
	mov 	edi, OFFSET buffer+65
	mov 	ecx, 5
	call 	moveString
	
	mov 	esi, OFFSET rank3.player
	mov 	edi, OFFSET buffer+70
	mov 	ecx, 30
	call 	moveString
	
	mov 	esi, OFFSET rank3.score
	mov 	edi, OFFSET buffer+100
	mov 	ecx, 5
	call 	moveString
	
	mov 	esi, OFFSET rank4.player
	mov 	edi, OFFSET buffer+105
	mov 	ecx, 30
	call 	moveString
	
	mov 	esi, OFFSET rank4.score
	mov 	edi, OFFSET buffer+135
	mov 	ecx, 5
	call 	moveString
	
	mov 	esi, OFFSET rank5.player
	mov 	edi, OFFSET buffer+140
	mov 	ecx, 30
	call 	moveString
	
	mov 	esi, OFFSET rank5.score
	mov 	edi, OFFSET buffer+170
	mov 	ecx, 5
	call 	moveString

	ret
rankIntoBuffer ENDP

; -----------------------------------------------
bufferIntoRank PROC
; -----------------------------------------------
	mov 	esi, OFFSET buffer
	mov 	edi, OFFSET rank1.player
	mov 	ecx, 30
	call 	moveString
	
	mov 	esi, OFFSET buffer+30
	mov 	edi, OFFSET rank1.score
	mov 	ecx, 5
	call 	moveString
	
	mov 	esi, OFFSET buffer+35
	mov 	edi, OFFSET rank2.player
	mov 	ecx, 30
	call 	moveString
	
	mov 	esi, OFFSET buffer+65
	mov 	edi, OFFSET rank2.score
	mov 	ecx, 5
	call 	moveString
	
	mov 	esi, OFFSET buffer+70
	mov 	edi, OFFSET rank3.player
	mov 	ecx, 30
	call 	moveString
	
	mov 	esi, OFFSET buffer+100
	mov 	edi, OFFSET rank3.score
	mov 	ecx, 5
	call 	moveString
	
	mov 	esi, OFFSET buffer+105
	mov 	edi, OFFSET rank4.player
	mov 	ecx, 30
	call 	moveString
	
	mov 	esi, OFFSET buffer+135
	mov 	edi, OFFSET rank4.score
	mov 	ecx, 5
	call 	moveString
	
	mov 	esi, OFFSET buffer+140
	mov 	edi, OFFSET rank5.player
	mov 	ecx, 30
	call 	moveString
	
	mov 	esi, OFFSET buffer+170
	mov 	edi, OFFSET rank5.score
	mov 	ecx, 5
	call 	moveString
	
	ret
bufferIntoRank ENDP

; --------------------------------------------------
showRank PROC
; --------------------------------------------------
	call 	ClrScr
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf

	mov 	al, 32
	mov 	edx, OFFSET buffer
	mov 	ecx, BUF_SIZE
	call	cleanString

	mov 	edx, OFFSET rankFont
	mov 	edi, OFFSET buffer
	call 	Read
	
	mov 	edx, OFFSET buffer
	call 	WriteString
	call 	Crlf
	call 	Crlf
	call 	Crlf
	
	mov 	eax, 32
	mov 	ecx, BUF_SIZE
	mov 	edx, OFFSET buffer
	call 	cleanString
	
	mov 	edx, OFFSET rankFile
	mov 	edi, OFFSET buffer
	call 	Read
	
	call 	bufferIntoRank
	
	mov 	edx, OFFSET first
	call 	WriteString
	mov 	edx, OFFSET rank1.player
	call 	myWrite
	mov 	edx, OFFSET rank1.score
	call 	WriteString
	call 	Crlf
	
	mov 	edx, OFFSET second
	call 	WriteString
	mov 	edx, OFFSET rank2.player
	call 	myWrite
	mov 	edx, OFFSET rank2.score
	call 	WriteString
	call 	Crlf
	
	mov 	edx, OFFSET third
	call 	WriteString
	mov 	edx, OFFSET rank3.player
	call 	myWrite
	mov 	edx, OFFSET rank3.score
	call 	WriteString
	call 	Crlf
	
	mov 	edx, OFFSET forth
	call 	WriteString
	mov 	edx, OFFSET rank4.player
	call 	myWrite
	mov 	edx, OFFSET rank4.score
	call 	WriteString
	call 	Crlf
	
	mov 	edx, OFFSET fifth
	call 	WriteString
	mov 	edx, OFFSET rank5.player
	call 	myWrite
	mov 	edx, OFFSET rank5.score
	call 	WriteString
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	
	mov 	edx, OFFSET promptback
	call 	WriteString
WAITING:
	call 	ReadChar
	cmp 	al, 'b'
	je 		DONE
	jmp 	WAITING
DONE:
	ret
showRank ENDP

debug PROC
	call 	ClrScr
	mov 	edx, OFFSET rankFile
	mov 	edi, OFFSET buffer
	call 	Read
	call 	bufferIntoRank
	
	mov 	edx, OFFSET promptPlayer
	call 	WriteString
	mov 	edx, OFFSET newrank.player
	mov 	ecx, 31
	call 	readString
	call 	Crlf
	mov 	edx, OFFSET promptScore
	call 	WriteString
	mov 	edx, OFFSET newrank.score
	mov 	ecx, 6
	call 	readString

	call 	sort

	call 	rankIntoBuffer
	call	write
	call	showRank

	exit
debug ENDP

;END showRank
END debug

