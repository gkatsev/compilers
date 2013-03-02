L245:
	addi t747, r0, 0
	j L244
L244:
L247:
L211	sw t748, (t659)
	addi t749, r0, 0
	sw t749, (t657)
	j L246
L246:
L211: .asciiz " "L249:
initArray	addi t752, r0, 10
	addi t753, r0, 0
	jal t751
	sw t750, (t569)
	addi t754, r0, 0
	sw t754, (t570)
	lw t757, ~4(t130)
	addi t759, r0, 4
	addi t760, r0, 2
	mult t758, t759, t760
	add t756, t757, t758
	lw t755, 0(t756)
	j L248
L248:
L251:
	addi t761, r0, 0
	sw t761, (t494)
L152	addi t763, r0, 0
	addi t764, r0, 2
	jal t762
	j L250
L250:
L152:
	lw t765, ~4(t130)
	j L252
L252:
L254:
	addi t766, r0, 0
	sw t766, (t420)
	addi t767, r0, 0
	sw t767, (t422)
	addi t768, r0, 100
	sw t768, (t423)
	addi t769, r0, 0
	addi t770, r0, 100
	ble t769, t770, L125
L124:
	j L253
L125:
	lw t772, ~4(t130)
	addi t771, t772, 1
	sw t771, ~4 (t130)
	addi t773, t422, 1
	sw t773, (t422)
L126:
	ble t422, t423, L125
L255:
	j L124
L253:
L257:
	addi t774, r0, 10
	addi t775, r0, 20
	bgt t774, t775, L99
L100:
	addi t776, r0, 40
	sw t776, (t358)
L101:
	j L256
L99:
	addi t777, r0, 30
	sw t777, (t358)
	j L101
L256:
L259:
L74	addi t779, r0, 0
L78	addi t781, r0, 0
	jal t778
	j L258
L258:
L78: .asciiz "str2"L75:
L74	addi t783, r0, 0
L76	lw t785, ~4(t130)
	jal t782
L77	j L260
L260:
L77: .asciiz " "L76: .asciiz "str"L74:
	j L261
L261:
L263:
L54	addi t788, r0, 0
L57	addi t790, r0, 0
	jal t787
	j L262
L262:
L57: .asciiz "str2"L55:
L54	addi t792, r0, 0
L56	lw t794, ~4(t130)
	jal t791
	j L264
L264:
L56: .asciiz "str"L54:
	j L265
L265:
L267:
malloc	addi t797, r0, 8
	jal t796
	sw t795, (t209)
	addi t798, r0, 0
	sw t798, 0 (t209)
	addi t799, r0, 0
	sw t799, 4 (t209)
	sw t209, (t210)
	lw t800, ~4(t130)
	j L266
L266:
L269:
L28	addi t802, r0, 0
	addi t803, r0, 10
	jal t801
	j L268
L268:
L28:
	lw t806, ~4(t130)
	addi t807, r0, 0
	beq t806, t807, L29
L30:
	lw t808, ~4(t130)
	sw t808, (t805)
L28	addi t811, r0, 0
	lw t813, ~4(t130)
	addi t814, r0, 1
	sub t812, t813, t814
	jal t810
	sw t809, (t804)
	mult t815, t805, t804
	sw t815, (t174)
L31:
	j L270
L29:
	addi t816, r0, 1
	sw t816, (t174)
	j L31
L270:
L272:
malloc	addi t819, r0, 8
	jal t818
	sw t817, (t154)
L20	sw t820, 0 (t154)
	addi t821, r0, 1000
	sw t821, 4 (t154)
	sw t154, (t155)
	lw t822, ~4(t130)
	j L271
L271:
L20: .asciiz "Nobody"L274:
initArray	addi t825, r0, 10
	addi t826, r0, 0
	jal t824
	sw t823, (t140)
	addi t827, r0, 0
	sw t827, (t141)
	lw t828, ~4(t130)
	j L273
L273:
L276:
initArray	addi t831, r0, 10
	addi t832, r0, 0
	jal t830
	sw t829, (t132)
	addi t833, r0, 0
	sw t833, (t133)
	lw t834, ~4(t130)
	j L275
L275:
