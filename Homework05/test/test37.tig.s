L213:
L211	sw t660, (t659)
	addi t661, r0, 0
	sw t661, (t657)
	j L212
L212:
L211: .asciiz " "L215:
initArray	addi t664, r0, 10
	addi t665, r0, 0
	jal t663
	sw t662, (t569)
	addi t666, r0, 0
	sw t666, (t570)
	lw t669, ~4(t130)
	addi t671, r0, 4
	addi t672, r0, 2
	mult t670, t671, t672
	add t668, t669, t670
	lw t667, 0(t668)
	j L214
L214:
L217:
	addi t673, r0, 0
	sw t673, (t494)
L152	addi t675, r0, 0
	addi t676, r0, 2
	jal t674
	j L216
L216:
L152:
	lw t677, ~4(t130)
	j L218
L218:
L220:
	addi t678, r0, 0
	sw t678, (t420)
	addi t679, r0, 0
	sw t679, (t422)
	addi t680, r0, 100
	sw t680, (t423)
	addi t681, r0, 0
	addi t682, r0, 100
	ble t681, t682, L125
L124:
	j L219
L125:
	lw t684, ~4(t130)
	addi t683, t684, 1
	sw t683, ~4 (t130)
	addi t685, t422, 1
	sw t685, (t422)
L126:
	ble t422, t423, L125
L221:
	j L124
L219:
L223:
	addi t686, r0, 10
	addi t687, r0, 20
	bgt t686, t687, L99
L100:
	addi t688, r0, 40
	sw t688, (t358)
L101:
	j L222
L99:
	addi t689, r0, 30
	sw t689, (t358)
	j L101
L222:
L225:
L74	addi t691, r0, 0
L78	addi t693, r0, 0
	jal t690
	j L224
L224:
L78: .asciiz "str2"L75:
L74	addi t695, r0, 0
L76	lw t697, ~4(t130)
	jal t694
L77	j L226
L226:
L77: .asciiz " "L76: .asciiz "str"L74:
	j L227
L227:
L229:
L54	addi t700, r0, 0
L57	addi t702, r0, 0
	jal t699
	j L228
L228:
L57: .asciiz "str2"L55:
L54	addi t704, r0, 0
L56	lw t706, ~4(t130)
	jal t703
	j L230
L230:
L56: .asciiz "str"L54:
	j L231
L231:
L233:
malloc	addi t709, r0, 8
	jal t708
	sw t707, (t209)
	addi t710, r0, 0
	sw t710, 0 (t209)
	addi t711, r0, 0
	sw t711, 4 (t209)
	sw t209, (t210)
	lw t712, ~4(t130)
	j L232
L232:
L235:
L28	addi t714, r0, 0
	addi t715, r0, 10
	jal t713
	j L234
L234:
L28:
	lw t718, ~4(t130)
	addi t719, r0, 0
	beq t718, t719, L29
L30:
	lw t720, ~4(t130)
	sw t720, (t717)
L28	addi t723, r0, 0
	lw t725, ~4(t130)
	addi t726, r0, 1
	sub t724, t725, t726
	jal t722
	sw t721, (t716)
	mult t727, t717, t716
	sw t727, (t174)
L31:
	j L236
L29:
	addi t728, r0, 1
	sw t728, (t174)
	j L31
L236:
L238:
malloc	addi t731, r0, 8
	jal t730
	sw t729, (t154)
L20	sw t732, 0 (t154)
	addi t733, r0, 1000
	sw t733, 4 (t154)
	sw t154, (t155)
	lw t734, ~4(t130)
	j L237
L237:
L20: .asciiz "Nobody"L240:
initArray	addi t737, r0, 10
	addi t738, r0, 0
	jal t736
	sw t735, (t140)
	addi t739, r0, 0
	sw t739, (t141)
	lw t740, ~4(t130)
	j L239
L239:
L242:
initArray	addi t743, r0, 10
	addi t744, r0, 0
	jal t742
	sw t741, (t132)
	addi t745, r0, 0
	sw t745, (t133)
	lw t746, ~4(t130)
	j L241
L241:
