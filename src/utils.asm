.data
	bytesRead DWORD ?
.code
;------------------------------------------------------
OpenInputFile PROC
;
; Opens an existing file for input.
; Receives: EDX points to the filename.
; Returns: If the file was opened successfully, EAX 
; contains a valid file handle. Otherwise, EAX equals 
; INVALID_HANDLE_VALUE.
; Last update: 6/8/2005
;------------------------------------------------------

	INVOKE CreateFile,
	  edx, GENERIC_READ, DO_NOT_SHARE, NULL,
	  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
	ret
OpenInputFile ENDP


;--------------------------------------------------------
ReadFromFile PROC
;
; Reads an input file into a buffer. 
; Receives: EAX = file handle, EDX = buffer offset,
;    ECX = number of bytes to read
; Returns: If CF = 0, EAX = number of bytes read; if
;    CF = 1, EAX contains the system error code returned
;    by the GetLastError Win32 API function.
; Last update: 7/6/2005
;--------------------------------------------------------

	INVOKE ReadFile,
	    eax,	; file handle
	    edx,	; buffer pointer
	    ecx,	; max bytes to read
	    ADDR bytesRead,	; number of bytes read
	    0		; overlapped execution flag
	cmp	eax,0	; failed?
	jne	L1	; no: return bytesRead
	INVOKE GetLastError	; yes: EAX = error code
	stc		; set Carry flag
	jmp	L2
	    
L1:	mov	eax,bytesRead	; success
	clc		; clear Carry flag
	
L2:	ret
ReadFromFile ENDP

;------------------------------------------------------
CreateOutputFile PROC
;
; Creates a new file and opens it in output mode.
; Receives: EDX points to the filename.
; Returns: If the file was created successfully, EAX 
;   contains a valid file handle. Otherwise, EAX  
;   equals INVALID_HANDLE_VALUE.
;------------------------------------------------------
	INVOKE CreateFile,
	  edx, GENERIC_WRITE, DO_NOT_SHARE, NULL,
	  CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
	ret
CreateOutputFile ENDP


;--------------------------------------------------------
WriteToFile PROC
;
; Writes a buffer to an output file.
; Receives: EAX = file handle, EDX = buffer offset,
;    ECX = number of bytes to write
; Returns: EAX = number of bytes written to the file.
; Last update: 6/8/2005
;--------------------------------------------------------
.data
WriteToFile_1 DWORD ?    	; number of bytes written
.code
	INVOKE WriteFile,	; write buffer to file
		eax,	; file handle
		edx,	; buffer pointer
		ecx,	; number of bytes to write
		ADDR WriteToFile_1,	; number of bytes written
		0	; overlapped execution flag
	mov	eax,WriteToFile_1	; return value
	ret
WriteToFile ENDP


;--------------------------------------------------------
CloseFile PROC
;
; Closes a file using its handle as an identifier. 
; Receives: EAX = file handle 
; Returns: EAX = nonzero if the file is successfully 
;   closed.
; Last update: 6/8/2005
;--------------------------------------------------------

	INVOKE CloseHandle, eax
	ret
CloseFile ENDP