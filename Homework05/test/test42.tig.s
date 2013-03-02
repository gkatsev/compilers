L288:
malloc	addi t850, r0, 8
	jal t849
	sw t848, (t845)
L283	sw t851, 0 (t845)
	addi t852, t845, 4
	sw t852, (t847)
initArray	addi t855, r0, 3
	addi t856, r0, 1900
	jal t854
	sw t853, (t844)
	addi t857, r0, 0
	sw t857, (t847)
	sw t845, (t846)
malloc	addi t860, r0, 16
	jal t859
	sw t858, (t842)
L281	sw t861, 0 (t842)
L282	sw t862, 4 (t842)
	addi t863, r0, 2432
	sw t863, 8 (t842)
	addi t864, r0, 44
	sw t864, 12 (t842)
	sw t842, (t843)
initArray	addi t867, r0, 100
L280	jal t866
	sw t865, (t840)
	addi t869, r0, 0
	sw t869, (t841)
malloc	addi t872, r0, 16
	jal t871
	sw t870, (t837)
L278	sw t873, 0 (t837)
L279	sw t874, 4 (t837)
	addi t875, r0, 0
	sw t875, 8 (t837)
	addi t876, r0, 0
	sw t876, 12 (t837)
initArray	addi t879, r0, 5
	jal t878
	sw t877, (t838)
	addi t880, r0, 0
	sw t880, (t839)
initArray	addi t883, r0, 10
	addi t884, r0, 0
	jal t882
	sw t881, (t835)
	addi t885, r0, 0
	sw t885, (t836)
	addi t886, r0, 1
	lw t888, ~4(t130)
	addi t890, r0, 4
	addi t891, r0, 0
	mult t889, t890, t891
	add t887, t888, t889
	sw t886, (t887)
	addi t892, r0, 3
	lw t894, ~4(t130)
	addi t896, r0, 4
	addi t897, r0, 9
	mult t895, t896, t897
	add t893, t894, t895
	sw t892, (t893)
L284	addi t899, r0, 0
	sw t898, (t899)
	addi t900, r0, 23
	addi t901, r0, 0
	sw t900, (t901)
L285	lw t904, ~4(t130)
	addi t906, r0, 4
	addi t907, r0, 34
	mult t905, t906, t907
	add t903, t904, t905
	sw t902, (t903)
L286	lw t909, ~4(t130)
	sw t908, 0 (t909)
	addi t910, r0, 2323
	lw t913, ~4(t130)
	lw t912, 4(t913)
	addi t915, r0, 4
	addi t916, r0, 0
	mult t914, t915, t916
	add t911, t912, t914
	sw t910, (t911)
	addi t917, r0, 2323
	lw t920, ~4(t130)
	lw t919, 4(t920)
	addi t922, r0, 4
	addi t923, r0, 2
	mult t921, t922, t923
	add t918, t919, t921
	sw t917, (t918)
	j L287
L287:
L286: .asciiz "sdf"L285: .asciiz "sfd"L284: .asciiz "kati"L283: .asciiz "Allos"L282: .asciiz "Kapou"L281: .asciiz "Kapoios"L280: .asciiz ""L279: .asciiz "somewhere"L278: .asciiz "aname"L290:
	addi t924, r0, 0
	j L289
L289:
L292:
L211	sw t925, (t659)
	addi t926, r0, 0
	sw t926, (t657)
	j L291
L291:
L211: .asciiz " "L294:
initArray	addi t929, r0, 10
	addi t930, r0, 0
	jal t928
	sw t927, (t569)
	addi t931, r0, 0
	sw t931, (t570)
	lw t934, ~4(t130)
	addi t936, r0, 4
	addi t937, r0, 2
	mult t935, t936, t937
	add t933, t934, t935
	lw t932, 0(t933)
	j L293
L293:
L296:
	addi t938, r0, 0
	sw t938, (t494)
L152	addi t940, r0, 0
	addi t941, r0, 2
	jal t939
	j L295
L295:
L152:
	lw t942, ~4(t130)
	j L297
L297:
L299:
	addi t943, r0, 0
	sw t943, (t420)
	addi t944, r0, 0
	sw t944, (t422)
	addi t945, r0, 100
	sw t945, (t423)
	addi t946, r0, 0
	addi t947, r0, 100
	ble t946, t947, L125
L124:
	j L298
L125:
	lw t949, ~4(t130)
	addi t948, t949, 1
	sw t948, ~4 (t130)
	addi t950, t422, 1
	sw t950, (t422)
L126:
	ble t422, t423, L125
L300:
	j L124
L298:
L302:
	addi t951, r0, 10
	addi t952, r0, 20
	bgt t951, t952, L99
L100:
	addi t953, r0, 40
	sw t953, (t358)
L101:
	j L301
L99:
	addi t954, r0, 30
	sw t954, (t358)
	j L101
L301:
L304:
L74	addi t956, r0, 0
L78	addi t958, r0, 0
	jal t955
	j L303
L303:
L78: .asciiz "str2"L75:
L74	addi t960, r0, 0
L76	lw t962, ~4(t130)
	jal t959
L77	j L305
L305:
L77: .asciiz " "L76: .asciiz "str"L74:
	j L306
L306:
L308:
L54	addi t965, r0, 0
L57	addi t967, r0, 0
	jal t964
	j L307
L307:
L57: .asciiz "str2"L55:
L54	addi t969, r0, 0
L56	lw t971, ~4(t130)
	jal t968
	j L309
L309:
L56: .asciiz "str"L54:
	j L310
L310:
L312:
malloc	addi t974, r0, 8
	jal t973
	sw t972, (t209)
	addi t975, r0, 0
	sw t975, 0 (t209)
	addi t976, r0, 0
	sw t976, 4 (t209)
	sw t209, (t210)
	lw t977, ~4(t130)
	j L311
L311:
L314:
L28	addi t979, r0, 0
	addi t980, r0, 10
	jal t978
	j L313
L313:
L28:
	lw t983, ~4(t130)
	addi t984, r0, 0
	beq t983, t984, L29
L30:
	lw t985, ~4(t130)
	sw t985, (t982)
L28	addi t988, r0, 0
	lw t990, ~4(t130)
	addi t991, r0, 1
	sub t989, t990, t991
	jal t987
	sw t986, (t981)
	mult t992, t982, t981
	sw t992, (t174)
L31:
	j L315
L29:
	addi t993, r0, 1
	sw t993, (t174)
	j L31
L315:
L317:
malloc	addi t996, r0, 8
	jal t995
	sw t994, (t154)
L20	sw t997, 0 (t154)
	addi t998, r0, 1000
	sw t998, 4 (t154)
	sw t154, (t155)
	lw t999, ~4(t130)
	j L316
L316:
L20: .asciiz "Nobody"L319:
initArray	addi t1002, r0, 10
	addi t1003, r0, 0
	jal t1001
	sw t1000, (t140)
	addi t1004, r0, 0
	sw t1004, (t141)
	lw t1005, ~4(t130)
	j L318
L318:
L321:
initArray	addi t1008, r0, 10
	addi t1009, r0, 0
	jal t1007
	sw t1006, (t132)
	addi t1010, r0, 0
	sw t1010, (t133)
	lw t1011, ~4(t130)
	j L320
L320:
