L16:
	addi t136, r0, 0
	sw t136, (t132)
	addi t137, r0, 0
	sw t137, (t134)
	addi t138, r0, 100
	sw t138, (t135)
	addi t139, r0, 0
	addi t140, r0, 100
	ble t139, t140, L13
L12:
	j L15
L13:
	lw t142, ~4(t130)
	addi t141, t142, 1
	sw t141, ~4 (t130)
	addi t143, t134, 1
	sw t143, (t134)
L14:
	ble t134, t135, L13
L17:
	j L12
L15:
