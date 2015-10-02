; =============================================================================
; BareMetal -- a 64-bit OS written in Assembly for x86-64 systems
; Copyright (C) 2008-2014 Return Infinity -- see LICENSE.TXT
;
; Raw disk access syscalls
;
; =============================================================================

align 16
db 'DEBUG: RAWHDD '
align 16

; -----------------------------------------------------------------------------
; readsectors -- Read sectors on the hard drive
; IN:	RAX = starting sector to read
;	RCX = number of sectors to read (1 - 256)
;	RDX = disk # (currently ignored)
;	RDI = memory location to store sectors
; OUT:	RAX = RAX + number of sectors that were read
;	RCX = number of sectors that were read (0 on error)
;	RDI = RDI + (number of sectors * 512)
;	All other registers preserved

; -----------------------------------------------------------------------------
; os_readsectors -- Read sectors on the hard drive
; IN:	RDI = memory location to store sectors
;	RSI = starting sector to read
;	RDX = number of sectors to read (1 - 256)
;	RCX = disk # (currently ignored)
; OUT:	RAX = number of sectors that were read (0 on error)
os_readsectors:
	mov rax, rsi
	xchg rcx, rdx
	call readsectors
	mov rax, rcx
	ret

; -----------------------------------------------------------------------------
; writesectors -- Write sectors on the hard drive
; IN:	RAX = starting sector to write
;	RCX = number of sectors to write (1 - 256)
;	RDX = disk # (currently ignored)
;	RSI = memory location of sectors
; OUT:	RAX = RAX + number of sectors that were written
;	RCX = number of sectors that were written (0 on error)
;	RSI = RSI + (number of sectors * 512)
;	All other registers preserved

; -----------------------------------------------------------------------------
; os_writesectors -- Write sectors on the hard drive
; IN:	RDI = starting sector to write
; 	RSI = memory location of sectors
;	RDX = number of sectors to write (1 - 256)
;	RCX = disk # (currently ignored)
; OUT:	RAX = number of sectors that were written (0 on error)
os_writesectors:
	mov rax, rdi
	xchg rcx, rdx
	call writesectors
	mov rax, rcx
	ret
