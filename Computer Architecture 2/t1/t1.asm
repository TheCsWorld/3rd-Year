.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive

.data								; start of a data section
public g							; export variable g
g DWORD 4							; declare global variable g initialised to 4

.code

;
; t1.asm
;
;

;
; example mixing C/C++ and IA32 assembly language
;
; use stack for local variables
;
; simple mechanical code generation which doesn't make good use of the registers
;
; 06/10/14  used ecx instead of ebx to initialise fi and fj as ecx volatile

			mov ebx, g				;put g in register

public      min_IA32               ; make sure function name is exported

min_IA32:	push    ebp             ; push frame pointer
            mov     ebp, esp        ; update ebp
            sub     esp, 4          ; space for local variable v [ebp-4]
			push	ebx				; save g to stack
			mov     eax, [ebp+8]    ; eax = a
			mov		ebx, [ebp+12]	; ebx = b
			mov		ecx, [ebp+16]	; ecx = c
			cmp		eax, ebx		; if(b < v)i.e. a
			jge		compareAtoC
			mov		eax, ebx		; return a = b
			;jmp		return
compareAtoC:
			cmp		eax, ecx		; if(c < a)
			jge		return
			mov		eax, ecx		; return a = c
			jmp		return			;
return:
			pop		ebx				; restore g
			mov		esp, ebp		; restore esp
			pop		ebp				; restore previous ebp
			ret		0				; return from function


public		p_IA32				

p_IA32:		push    ebp             ; push frame pointer
            mov     ebp, esp        ; update ebp
			mov		eax, [ebp+8]		; eax = i	(g is in ebx!)
			mov		ecx, [ebp+12]		; ecx = j
callmin:
			push	ecx				; push j to stack
			push	eax				; push i to stack
			push	ebx				; push g to stack
			jmp		min_IA32

			mov		eax, [ebp+16]		; push k to stack	(g is in ebx!)
			mov		ecx, [ebp+20]		; push l to stack
			jmp		callmin
			mov		esp, ebp		; retore esp
			pop		ebp				; restore previous ebp
			ret		0				;return from function


public		gcd_IA32

gcd_IA32:	push    ebp             ; push frame pointer
            mov     ebp, esp        ; update ebp
			mov		eax, [ebp+8]	; eax = a
			mov		ebx, [ebp+12]	; ebx = b
			cmp		ebx, 0			; if(b==0)
			jne		AmodB
			jmp		return1			; return
AmodB:		
			cdq						; extend eax -> edx:eax
			idiv	ebx				; divide edx:eax by ebx
			push	edx				; store a%b on stack
			push	ebx				; store b on stack
			jmp		gcd_IA32		;gcd(b, a%b)
return1:
			pop		ebx				; restore g
			mov		esp, ebp		; restore esp
			pop		ebp				; restore previous ebp
			ret		0				; return from function



;mov eax, -1      ; Put -1 in eax
;mov ebx, 1       ; put  1 in ebx
;
;cdq              ; sign extend eax -> edx:eax = -1
;idiv ebx         ; divide edx:eax (-1) by ebx (1)
;                 ;   result goes in eax, so now eax = -1
;ret              ; return eax (-1) to caller

end