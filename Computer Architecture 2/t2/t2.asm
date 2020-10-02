
;.686                                ; create 32 bit code
;.model flat, C                      ; 32 bit memory model
option casemap:none                ; case sensitive
includelib legacy_stdio_definitions.lib
extrn printf:near

.data								; start of a data section
public g							; export variable g
g QWORD 4							; declare global variable g initialised to 4

.code
;
; t2.asm
;

; 
;
	qf db 'a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d sum = %I64d\n', 0AH, 00H 
	qnsf db		  'qns',0AH,00H

public  min                      ; export function name

min:	sub	rsp, 32					;shadow space
		mov rax, rcx				;v=a
		cmp	rdx, rax				;if(b<v)
		jge	compareAtoC
		mov	rax, rdx				;v=b
compareAtoC:
		cmp r8, rax					;if(c<v)
		jge return
		mov rax, r8					;v=c
		jmp return
return:
		add rsp, 32
		ret 0

public		p				

p:			sub	rsp, 32             ; shadow space
			mov	rbx, r8				;rbx=k
			mov	r8, rdx				; r8 = j
			mov	rdx, rcx			;rdx=i
			mov rcx, g				;g=rcx
			call min				;min(g,i,j)
			mov r8, r9				;r8 = l
			mov	rdx, rbx			;rdx = k
			mov rcx, rax			;rcx = min(g,i,j)
			call min				;min(g,k,l)
			;pop rbx
			add rsp, 32
			ret		0				;return from function

public		gcd

;rcx=a,rdx=b,
gcd:		sub	rsp, 32				;shadow space
			mov	rax, rcx			;rax=a	
			mov rcx, rdx			;rcx=b
			test rdx, rdx				;if(b=0)
			je	return1
			xor	rdx, rdx
			cqo						;extend rax -> rdx:rax
			idiv	rcx					; divide rdx:rax by rcx
			;mov r8, rdx				;r8=a%b
			;mov rdx, r8				;rdx=a%b
			call	gcd				;gcd(b, a%b)
return1:
			;mov rax, rdx			;return 0
			add rsp, 32				;deallocate shadow space
			ret	0

public		q
			;how do I sort out d and e?
q:			sub rsp, 56				;shadow space
			xor	rbx, rbx			;sum=0
			add rbx, rcx			;sum+=a
			add	rbx, rdx			;sum+=b
			add	rbx, r8				;sum+=c
			add rbx, r9				;sum+=d	
			add rbx, [rsp+96]		;sum+=e
			mov [rsp+80], rbx		;preserve sum in shadow space
			mov [rsp+48], rbx		;sum=parameter 7 for printf
			mov rbx, [rsp+96]		;rbx = e
			mov [rsp+40], rbx		;e=parameter 6 for printf
			mov [rsp+32], r9		;d=parameter 5 for printf
			mov r9, r8				;r9=c
			mov r8, rdx				;r8=b
			mov	rdx, rcx			;rdx=a
			lea rcx, qf				;rcx = printf
			call printf				;printf(a,b,c,d,e,sum)
			mov rax, [rsp+80]		; function result in rax = sum
			add rsp, 56				; deallocate shadow space
			ret 0					;return 0

public		qns

qns:		sub rsp, 32 
			lea rcx, qnsf			;&qnsf = parameter 1 for printf
			call printf				;printf(qnsf)
			mov rax, 0				;return 0 as a result
			add rsp, 32
			ret 0

public		qnsa

qnsa:		lea rcx, qnsf			;&qnsf = parameter 1 for printf
			call printf				;printf(qnsf)
			mov rax, 0				;return 0 as a result
			ret 0	

            end
    