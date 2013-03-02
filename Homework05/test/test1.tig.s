L13:
	addi t135, r0, 10
	addi t136, r0, 0
	jal initArray
	sw t134, (t132)
	addi t137, r0, 0
	sw t137, (t133)
	lw t138, ~4(t130)
	j L12
L12:
