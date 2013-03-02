L59:
L54	addi t253, r0, 0
L57	addi t255, r0, 0
	jal t252
	j L58
L58:
L57: .asciiz "str2"L55:
L54	addi t257, r0, 0
L56	lw t259, ~4(t130)
	jal t256
	j L60
L60:
L56: .asciiz "str"L54:
	j L61
L61:
L63:
malloc	addi t262, r0, 8
	jal t261
	sw t260, (t209)
	addi t263, r0, 0
	sw t263, 0 (t209)
	addi t264, r0, 0
	sw t264, 4 (t209)
	sw t209, (t210)
	lw t265, ~4(t130)
	j L62
L62:
L65:
L28	addi t267, r0, 0
	addi t268, r0, 10
	jal t266
	j L64
L64:
L28:
	lw t271, ~4(t130)
	addi t272, r0, 0
	beq t271, t272, L29
L30:
	lw t273, ~4(t130)
	sw t273, (t270)
L28	addi t276, r0, 0
	lw t278, ~4(t130)
	addi t279, r0, 1
	sub t277, t278, t279
	jal t275
	sw t274, (t269)
	mult t280, t270, t269
	sw t280, (t174)
L31:
	j L66
L29:
	addi t281, r0, 1
	sw t281, (t174)
	j L31
L66:
L68:
malloc	addi t284, r0, 8
	jal t283
	sw t282, (t154)
L20	sw t285, 0 (t154)
	addi t286, r0, 1000
	sw t286, 4 (t154)
	sw t154, (t155)
	lw t287, ~4(t130)
	j L67
L67:
L20: .asciiz "Nobody"L70:
initArray	addi t290, r0, 10
	addi t291, r0, 0
	jal t289
	sw t288, (t140)
	addi t292, r0, 0
	sw t292, (t141)
	lw t293, ~4(t130)
	j L69
L69:
L72:
initArray	addi t296, r0, 10
	addi t297, r0, 0
	jal t295
	sw t294, (t132)
	addi t298, r0, 0
	sw t298, (t133)
	lw t299, ~4(t130)
	j L71
L71:
