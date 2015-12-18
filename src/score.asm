INCLUDE Irvine32.inc
INCLUDE utils.asm

; Max character read into buffer string.
BUF_SIZE EQU 2048

.data
	hFile 		DWORD ?
	buffer 		BYTE BUF_SIZE DUP(0), 0
	rankFont 	BYTE "rankFont.txt", 0
	rankFile 	BYTE "score.txt"

.code

; -----------------------------------------------
cleanString PROC
; eax -> character
; ecx -> string size
; edx -> string head
; -----------------------------------------------
	mov 	esi, 0
START:
	mov 	[edx+esi], eax
	inc 	esi
	loop 	START
cleanString ENDP

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
FILE_ERROR:
	mov 	eax, hFile
	call 	CloseFile
	ret
Read ENDP

showRank PROC
	call 	ClrScr
	mov 	edx, OFFSET rankFont
	mov 	edi, OFFSET buffer
	call 	Read
	
	mov 	edx, OFFSET buffer
	call 	WriteString
	call 	Crlf
	call 	Crlf
	call 	Crlf
	call 	Crlf
	
	mov 	eax, 0
	mov 	ecx, BUF_SIZE
	mov 	edx, OFFSET buffer
	call 	cleanString
	
	mov 	edx, OFFSET rankFile
	mov 	edi, OFFSET buffer
	call 	Read
	
	mov 	edx, OFFSET buffer
	call 	WriteString
	call 	Crlf
	
	exit
showRank ENDP

END showRank


