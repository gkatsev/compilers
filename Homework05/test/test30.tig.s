L182:
initArray	addi t573, r0, 10
	addi t574, r0, 0
	jal t572
	sw t571, (t569)
	addi t575, r0, 0
	sw t575, (t570)
	lw t578, ~4(t130)
	addi t580, r0, 4
	addi t581, r0, 2
	mult t579, t580, t581
	add t577, t578, t579
	lw t576, 0(t577)
	j L181
L181:
L184:
	addi t582, r0, 0
	sw t582, (t494)
L152	addi t584, r0, 0
	addi t585, r0, 2
	jal t583
	j L183
L183:
L152:
	lw t586, ~4(t130)
	j L185
L185:
L187:
	addi t587, r0, 0
	sw t587, (t420)
	addi t588, r0, 0
	sw t588, (t422)
	addi t589, r0, 100
	sw t589, (t423)
	addi t590, r0, 0
	addi t591, r0, 100
	ble t590, t591, L125
L124:
	j L186
L125:
	lw t593, ~4(t130)
	addi t592, t593, 1
	sw t592, ~4 (t130)
	addi t594, t422, 1
	sw t594, (t422)
L126:
	ble t422, t423, L125
L188:
	j L124
L186:
L190:
	addi t595, r0, 10
	addi t596, r0, 20
	bgt t595, t596, L99
L100:
	addi t597, r0, 40
	sw t597, (t358)
L101:
	j L189
L99:
	addi t598, r0, 30
	sw t598, (t358)
	j L101
L189:
L192:
L74	addi t600, r0, 0
L78	addi t602, r0, 0
	jal t599
	j L191
L191:
L78: .asciiz "str2"L75:
L74	addi t604, r0, 0
L76	lw t606, ~4(t130)
	jal t603
L77	j L193
L193:
L77: .asciiz " "L76: .asciiz "str"L74:
	j L194
L194:
L196:
L54	addi t609, r0, 0
L57	addi t611, r0, 0
	jal t608
	j L195
L195:
L57: .asciiz "str2"L55:
L54	addi t613, r0, 0
L56	lw t615, ~4(t130)
	jal t612
	j L197
L197:
L56: .asciiz "str"L54:
	j L198
L198:
L200:
malloc	addi t618, r0, 8
	jal t617
	sw t616, (t209)
	addi t619, r0, 0
	sw t619, 0 (t209)
	addi t620, r0, 0
	sw t620, 4 (t209)
	sw t209, (t210)
	lw t621, ~4(t130)
	j L199
L199:
L202:
L28	addi t623, r0, 0
	addi t624, r0, 10
	jal t622
	j L201
L201:
L28:
	lw t627, ~4(t130)
	addi t628, r0, 0
	beq t627, t628, L29
L30:
	lw t629, ~4(t130)
	sw t629, (t626)
L28	addi t632, r0, 0
	lw t634, ~4(t130)
	addi t635, r0, 1
	sub t633, t634, t635
	jal t631
	sw t630, (t625)
	mult t636, t626, t625
	sw t636, (t174)
L31:
	j L203
L29:
	addi t637, r0, 1
	sw t637, (t174)
	j L31
L203:
L205:
malloc	addi t640, r0, 8
	jal t639
	sw t638, (t154)
L20	sw t641, 0 (t154)
	addi t642, r0, 1000
	sw t642, 4 (t154)
	sw t154, (t155)
	lw t643, ~4(t130)
	j L204
L204:
L20: .asciiz "Nobody"L207:
initArray	addi t646, r0, 10
	addi t647, r0, 0
	jal t645
	sw t644, (t140)
	addi t648, r0, 0
	sw t648, (t141)
	lw t649, ~4(t130)
	j L206
L206:
L209:
initArray	addi t652, r0, 10
	addi t653, r0, 0
	jal t651
	sw t650, (t132)
	addi t654, r0, 0
	sw t654, (t133)
	lw t655, ~4(t130)
	j L208
L208:
