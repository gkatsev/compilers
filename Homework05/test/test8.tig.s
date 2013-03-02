L103:
	addi t359, r0, 10
	addi t360, r0, 20
	bgt t359, t360, L99
L100:
	addi t361, r0, 40
	sw t361, (t358)
L101:
	j L102
L99:
	addi t362, r0, 30
	sw t362, (t358)
	j L101
L102:
L105:
L74	addi t364, r0, 0
L78	addi t366, r0, 0
	jal t363
	j L104
L104:
L78: .asciiz "str2"L75:
L74	addi t368, r0, 0
L76	lw t370, ~4(t130)
	jal t367
L77	j L106
L106:
L77: .asciiz " "L76: .asciiz "str"L74:
	j L107
L107:
L109:
L54	addi t373, r0, 0
L57	addi t375, r0, 0
	jal t372
	j L108
L108:
L57: .asciiz "str2"L55:
L54	addi t377, r0, 0
L56	lw t379, ~4(t130)
	jal t376
	j L110
L110:
L56: .asciiz "str"L54:
	j L111
L111:
L113:
malloc	addi t382, r0, 8
	jal t381
	sw t380, (t209)
	addi t383, r0, 0
	sw t383, 0 (t209)
	addi t384, r0, 0
	sw t384, 4 (t209)
	sw t209, (t210)
	lw t385, ~4(t130)
	j L112
L112:
L115:
L28	addi t387, r0, 0
	addi t388, r0, 10
	jal t386
	j L114
L114:
L28:
	lw t391, ~4(t130)
	addi t392, r0, 0
	beq t391, t392, L29
L30:
	lw t393, ~4(t130)
	sw t393, (t390)
L28	addi t396, r0, 0
	lw t398, ~4(t130)
	addi t399, r0, 1
	sub t397, t398, t399
	jal t395
	sw t394, (t389)
	mult t400, t390, t389
	sw t400, (t174)
L31:
	j L116
L29:
	addi t401, r0, 1
	sw t401, (t174)
	j L31
L116:
L118:
malloc	addi t404, r0, 8
	jal t403
	sw t402, (t154)
L20	sw t405, 0 (t154)
	addi t406, r0, 1000
	sw t406, 4 (t154)
	sw t154, (t155)
	lw t407, ~4(t130)
	j L117
L117:
L20: .asciiz "Nobody"L120:
initArray	addi t410, r0, 10
	addi t411, r0, 0
	jal t409
	sw t408, (t140)
	addi t412, r0, 0
	sw t412, (t141)
	lw t413, ~4(t130)
	j L119
L119:
L122:
initArray	addi t416, r0, 10
	addi t417, r0, 0
	jal t415
	sw t414, (t132)
	addi t418, r0, 0
	sw t418, (t133)
	lw t419, ~4(t130)
	j L121
L121:
