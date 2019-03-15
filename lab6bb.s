	.data
str:	.ascii "ABXYPQRMNCEDKLJOSHTUFVZGWI\n"
ipString:	.ascii " "
		.skip 80
	.text
	.global read
read:
	MOV r7,#3
	MOV r0,#0
	MOV r2,#80
	LDR r1,=ipString
	SWI 0

main:
	MOV r4,#0	@set i=0
	LDR r7,=str	@r7 = str
	B LoopStr

LoopStr:
	LDRB r6,[r1,r4]	@ipString[i]
	CMP r6,#10	@ipString cmp \n
	BEQ write

	MOV r8,#0	@set j=0

set:
	LDRB r3,[r7,r8]	@str[j]
	CMP r6,r3	@cmp ipString[i],str[j]
	BNE incJ
	BLEQ encode1	@ipString[i]=str[j]
	ADD r4,r4,#1	@i++
	B LoopStr

incJ:
	ADD r8,r8,#1	@j++
	B set

encode1:
	CMP r8,#5
	BLT encode2
	SUB r9,r8,#5
	LDRB r10,[r7,r9]
	STRB r10,[r1,r4]
	MOV pc,lr
encode2:
	MOV r9,#21
	ADD r9,r9,r8
	LDRB r10,[r7,r9]
	STRB r10,[r1,r4]
	MOV pc,lr

write:
	MOV r7,#4
	MOV r0,#1
	MOV r2,#80
	LDR r1,=ipString
	SWI 0

exit:
	MOV r7,#1
	SWI 0
