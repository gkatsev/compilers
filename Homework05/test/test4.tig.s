L33:
L28	addi t176, r0, 0
	addi t177, r0, 10
	jal t175
	j L32
L32:
L28:
	lw t180, ~4(t130)
	addi t181, r0, 0
	beq t180, t181, L29
L30:
	lw t182, ~4(t130)
	sw t182, (t179)
L28	addi t185, r0, 0
	lw t187, ~4(t130)
	addi t188, r0, 1
	sub t186, t187, t188
	jal t184
	sw t183, (t178)
	mult t189, t179, t178
	sw t189, (t174)
L31:
	j L34
L29:
	addi t190, r0, 1
	sw t190, (t174)
	j L31
L34:
L36:
malloc	addi t193, r0, 8
	jal t192
	sw t191, (t154)
L20	sw t194, 0 (t154)
	addi t195, r0, 1000
	sw t195, 4 (t154)
	sw t154, (t155)
	lw t196, ~4(t130)
	j L35
L35:
L20: .asciiz "Nobody"L38:
initArray	addi t199, r0, 10
	addi t200, r0, 0
	jal t198
	sw t197, (t140)
	addi t201, r0, 0
	sw t201, (t141)
	lw t202, ~4(t130)
	j L37
L37:
L40:
initArray	addi t205, r0, 10
	addi t206, r0, 0
	jal t204
	sw t203, (t132)
	addi t207, r0, 0
	sw t207, (t133)
	lw t208, ~4(t130)
	j L39
L39:
