L14:
	addi t135, r0, 8
	jal malloc
	sw t134, (t132)
	la 0(t132), L12
	addi t137, r0, 1000
	sw t137, 4 (t132)
	sw t132, (t133)
	lw t138, ~4(t130)
	j L13
L13:
L12: .asciiz "Nobody"