INCLUDE Irvine32.inc
INCLUDE start.asm
INCLUDE game.asm

.data

.code
main PROC
	call 	start
	call	game

	exit			; Game over and exit.
main ENDP

END main
