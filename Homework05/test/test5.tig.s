L43:
malloc	addi t213, r0, 8
	jal t212
	sw t211, (t209)
	addi t214, r0, 0
	sw t214, 0 (t209)
	addi t215, r0, 0
	sw t215, 4 (t209)
	sw t209, (t210)
	lw t216, ~4(t130)
	j L42
L42:
L45:
L28	addi t218, r0, 0
	addi t219, r0, 10
	jal t217
	j L44
L44:
L28:
	lw t222, ~4(t130)
	addi t223, r0, 0
	beq t222, t223, L29
L30:
	lw t224, ~4(t130)
	sw t224, (t221)
L28	addi t227, r0, 0
	lw t229, ~4(t130)
	addi t230, r0, 1
	sub t228, t229, t230
	jal t226
	sw t225, (t220)
	mult t231, t221, t220
	sw t231, (t174)
L31:
	j L46
L29:
	addi t232, r0, 1
	sw t232, (t174)
	j L31
L46:
L48:
malloc	addi t235, r0, 8
	jal t234
	sw t233, (t154)
L20	sw t236, 0 (t154)
	addi t237, r0, 1000
	sw t237, 4 (t154)
	sw t154, (t155)
	lw t238, ~4(t130)
	j L47
L47:
L20: .asciiz "Nobody"L50:
initArray	addi t241, r0, 10
	addi t242, r0, 0
	jal t240
	sw t239, (t140)
	addi t243, r0, 0
	sw t243, (t141)
	lw t244, ~4(t130)
	j L49
L49:
L52:
initArray	addi t247, r0, 10
	addi t248, r0, 0
	jal t246
	sw t245, (t132)
	addi t249, r0, 0
	sw t249, (t133)
	lw t250, ~4(t130)
	j L51
L51:
