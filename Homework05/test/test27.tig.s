L154:
	addi t495, r0, 0
	sw t495, (t494)
L152	addi t497, r0, 0
	addi t498, r0, 2
	jal t496
	j L153
L153:
L152:
	lw t499, ~4(t130)
	j L155
L155:
L157:
	addi t500, r0, 0
	sw t500, (t420)
	addi t501, r0, 0
	sw t501, (t422)
	addi t502, r0, 100
	sw t502, (t423)
	addi t503, r0, 0
	addi t504, r0, 100
	ble t503, t504, L125
L124:
	j L156
L125:
	lw t506, ~4(t130)
	addi t505, t506, 1
	sw t505, ~4 (t130)
	addi t507, t422, 1
	sw t507, (t422)
L126:
	ble t422, t423, L125
L158:
	j L124
L156:
L160:
	addi t508, r0, 10
	addi t509, r0, 20
	bgt t508, t509, L99
L100:
	addi t510, r0, 40
	sw t510, (t358)
L101:
	j L159
L99:
	addi t511, r0, 30
	sw t511, (t358)
	j L101
L159:
L162:
L74	addi t513, r0, 0
L78	addi t515, r0, 0
	jal t512
	j L161
L161:
L78: .asciiz "str2"L75:
L74	addi t517, r0, 0
L76	lw t519, ~4(t130)
	jal t516
L77	j L163
L163:
L77: .asciiz " "L76: .asciiz "str"L74:
	j L164
L164:
L166:
L54	addi t522, r0, 0
L57	addi t524, r0, 0
	jal t521
	j L165
L165:
L57: .asciiz "str2"L55:
L54	addi t526, r0, 0
L56	lw t528, ~4(t130)
	jal t525
	j L167
L167:
L56: .asciiz "str"L54:
	j L168
L168:
L170:
malloc	addi t531, r0, 8
	jal t530
	sw t529, (t209)
	addi t532, r0, 0
	sw t532, 0 (t209)
	addi t533, r0, 0
	sw t533, 4 (t209)
	sw t209, (t210)
	lw t534, ~4(t130)
	j L169
L169:
L172:
L28	addi t536, r0, 0
	addi t537, r0, 10
	jal t535
	j L171
L171:
L28:
	lw t540, ~4(t130)
	addi t541, r0, 0
	beq t540, t541, L29
L30:
	lw t542, ~4(t130)
	sw t542, (t539)
L28	addi t545, r0, 0
	lw t547, ~4(t130)
	addi t548, r0, 1
	sub t546, t547, t548
	jal t544
	sw t543, (t538)
	mult t549, t539, t538
	sw t549, (t174)
L31:
	j L173
L29:
	addi t550, r0, 1
	sw t550, (t174)
	j L31
L173:
L175:
malloc	addi t553, r0, 8
	jal t552
	sw t551, (t154)
L20	sw t554, 0 (t154)
	addi t555, r0, 1000
	sw t555, 4 (t154)
	sw t154, (t155)
	lw t556, ~4(t130)
	j L174
L174:
L20: .asciiz "Nobody"L177:
initArray	addi t559, r0, 10
	addi t560, r0, 0
	jal t558
	sw t557, (t140)
	addi t561, r0, 0
	sw t561, (t141)
	lw t562, ~4(t130)
	j L176
L176:
L179:
initArray	addi t565, r0, 10
	addi t566, r0, 0
	jal t564
	sw t563, (t132)
	addi t567, r0, 0
	sw t567, (t133)
	lw t568, ~4(t130)
	j L178
L178:
