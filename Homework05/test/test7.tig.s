L80:
L74	addi t302, r0, 0
L78	addi t304, r0, 0
	jal t301
	j L79
L79:
L78: .asciiz "str2"L75:
L74	addi t306, r0, 0
L76	lw t308, ~4(t130)
	jal t305
L77	j L81
L81:
L77: .asciiz " "L76: .asciiz "str"L74:
	j L82
L82:
L84:
L54	addi t311, r0, 0
L57	addi t313, r0, 0
	jal t310
	j L83
L83:
L57: .asciiz "str2"L55:
L54	addi t315, r0, 0
L56	lw t317, ~4(t130)
	jal t314
	j L85
L85:
L56: .asciiz "str"L54:
	j L86
L86:
L88:
malloc	addi t320, r0, 8
	jal t319
	sw t318, (t209)
	addi t321, r0, 0
	sw t321, 0 (t209)
	addi t322, r0, 0
	sw t322, 4 (t209)
	sw t209, (t210)
	lw t323, ~4(t130)
	j L87
L87:
L90:
L28	addi t325, r0, 0
	addi t326, r0, 10
	jal t324
	j L89
L89:
L28:
	lw t329, ~4(t130)
	addi t330, r0, 0
	beq t329, t330, L29
L30:
	lw t331, ~4(t130)
	sw t331, (t328)
L28	addi t334, r0, 0
	lw t336, ~4(t130)
	addi t337, r0, 1
	sub t335, t336, t337
	jal t333
	sw t332, (t327)
	mult t338, t328, t327
	sw t338, (t174)
L31:
	j L91
L29:
	addi t339, r0, 1
	sw t339, (t174)
	j L31
L91:
L93:
malloc	addi t342, r0, 8
	jal t341
	sw t340, (t154)
L20	sw t343, 0 (t154)
	addi t344, r0, 1000
	sw t344, 4 (t154)
	sw t154, (t155)
	lw t345, ~4(t130)
	j L92
L92:
L20: .asciiz "Nobody"L95:
initArray	addi t348, r0, 10
	addi t349, r0, 0
	jal t347
	sw t346, (t140)
	addi t350, r0, 0
	sw t350, (t141)
	lw t351, ~4(t130)
	j L94
L94:
L97:
initArray	addi t354, r0, 10
	addi t355, r0, 0
	jal t353
	sw t352, (t132)
	addi t356, r0, 0
	sw t356, (t133)
	lw t357, ~4(t130)
	j L96
L96:
