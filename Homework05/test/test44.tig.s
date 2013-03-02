L324:
	addi t1013, r0, 0
	sw t1013, (t1012)
	addi t1014, r0, 0
	sw t1014, ~4 (t130)
	j L323
L323:
L326:
malloc	addi t1018, r0, 8
	jal t1017
	sw t1016, (t845)
L283	sw t1019, 0 (t845)
	addi t1020, t845, 4
	sw t1020, (t1015)
initArray	addi t1023, r0, 3
	addi t1024, r0, 1900
	jal t1022
	sw t1021, (t844)
	addi t1025, r0, 0
	sw t1025, (t1015)
	sw t845, (t846)
malloc	addi t1028, r0, 16
	jal t1027
	sw t1026, (t842)
L281	sw t1029, 0 (t842)
L282	sw t1030, 4 (t842)
	addi t1031, r0, 2432
	sw t1031, 8 (t842)
	addi t1032, r0, 44
	sw t1032, 12 (t842)
	sw t842, (t843)
initArray	addi t1035, r0, 100
L280	jal t1034
	sw t1033, (t840)
	addi t1037, r0, 0
	sw t1037, (t841)
malloc	addi t1040, r0, 16
	jal t1039
	sw t1038, (t837)
L278	sw t1041, 0 (t837)
L279	sw t1042, 4 (t837)
	addi t1043, r0, 0
	sw t1043, 8 (t837)
	addi t1044, r0, 0
	sw t1044, 12 (t837)
initArray	addi t1047, r0, 5
	jal t1046
	sw t1045, (t838)
	addi t1048, r0, 0
	sw t1048, (t839)
initArray	addi t1051, r0, 10
	addi t1052, r0, 0
	jal t1050
	sw t1049, (t835)
	addi t1053, r0, 0
	sw t1053, (t836)
	addi t1054, r0, 1
	lw t1056, ~4(t130)
	addi t1058, r0, 4
	addi t1059, r0, 0
	mult t1057, t1058, t1059
	add t1055, t1056, t1057
	sw t1054, (t1055)
	addi t1060, r0, 3
	lw t1062, ~4(t130)
	addi t1064, r0, 4
	addi t1065, r0, 9
	mult t1063, t1064, t1065
	add t1061, t1062, t1063
	sw t1060, (t1061)
L284	addi t1067, r0, 0
	sw t1066, (t1067)
	addi t1068, r0, 23
	addi t1069, r0, 0
	sw t1068, (t1069)
L285	lw t1072, ~4(t130)
	addi t1074, r0, 4
	addi t1075, r0, 34
	mult t1073, t1074, t1075
	add t1071, t1072, t1073
	sw t1070, (t1071)
L286	lw t1077, ~4(t130)
	sw t1076, 0 (t1077)
	addi t1078, r0, 2323
	lw t1081, ~4(t130)
	lw t1080, 4(t1081)
	addi t1083, r0, 4
	addi t1084, r0, 0
	mult t1082, t1083, t1084
	add t1079, t1080, t1082
	sw t1078, (t1079)
	addi t1085, r0, 2323
	lw t1088, ~4(t130)
	lw t1087, 4(t1088)
	addi t1090, r0, 4
	addi t1091, r0, 2
	mult t1089, t1090, t1091
	add t1086, t1087, t1089
	sw t1085, (t1086)
	j L325
L325:
L286: .asciiz "sdf"L285: .asciiz "sfd"L284: .asciiz "kati"L283: .asciiz "Allos"L282: .asciiz "Kapou"L281: .asciiz "Kapoios"L280: .asciiz ""L279: .asciiz "somewhere"L278: .asciiz "aname"L328:
	addi t1092, r0, 0
	j L327
L327:
L330:
L211	sw t1093, (t659)
	addi t1094, r0, 0
	sw t1094, (t657)
	j L329
L329:
L211: .asciiz " "L332:
initArray	addi t1097, r0, 10
	addi t1098, r0, 0
	jal t1096
	sw t1095, (t569)
	addi t1099, r0, 0
	sw t1099, (t570)
	lw t1102, ~4(t130)
	addi t1104, r0, 4
	addi t1105, r0, 2
	mult t1103, t1104, t1105
	add t1101, t1102, t1103
	lw t1100, 0(t1101)
	j L331
L331:
L334:
	addi t1106, r0, 0
	sw t1106, (t494)
L152	addi t1108, r0, 0
	addi t1109, r0, 2
	jal t1107
	j L333
L333:
L152:
	lw t1110, ~4(t130)
	j L335
L335:
L337:
	addi t1111, r0, 0
	sw t1111, (t420)
	addi t1112, r0, 0
	sw t1112, (t422)
	addi t1113, r0, 100
	sw t1113, (t423)
	addi t1114, r0, 0
	addi t1115, r0, 100
	ble t1114, t1115, L125
L124:
	j L336
L125:
	lw t1117, ~4(t130)
	addi t1116, t1117, 1
	sw t1116, ~4 (t130)
	addi t1118, t422, 1
	sw t1118, (t422)
L126:
	ble t422, t423, L125
L338:
	j L124
L336:
L340:
	addi t1119, r0, 10
	addi t1120, r0, 20
	bgt t1119, t1120, L99
L100:
	addi t1121, r0, 40
	sw t1121, (t358)
L101:
	j L339
L99:
	addi t1122, r0, 30
	sw t1122, (t358)
	j L101
L339:
L342:
L74	addi t1124, r0, 0
L78	addi t1126, r0, 0
	jal t1123
	j L341
L341:
L78: .asciiz "str2"L75:
L74	addi t1128, r0, 0
L76	lw t1130, ~4(t130)
	jal t1127
L77	j L343
L343:
L77: .asciiz " "L76: .asciiz "str"L74:
	j L344
L344:
L346:
L54	addi t1133, r0, 0
L57	addi t1135, r0, 0
	jal t1132
	j L345
L345:
L57: .asciiz "str2"L55:
L54	addi t1137, r0, 0
L56	lw t1139, ~4(t130)
	jal t1136
	j L347
L347:
L56: .asciiz "str"L54:
	j L348
L348:
L350:
malloc	addi t1142, r0, 8
	jal t1141
	sw t1140, (t209)
	addi t1143, r0, 0
	sw t1143, 0 (t209)
	addi t1144, r0, 0
	sw t1144, 4 (t209)
	sw t209, (t210)
	lw t1145, ~4(t130)
	j L349
L349:
L352:
L28	addi t1147, r0, 0
	addi t1148, r0, 10
	jal t1146
	j L351
L351:
L28:
	lw t1151, ~4(t130)
	addi t1152, r0, 0
	beq t1151, t1152, L29
L30:
	lw t1153, ~4(t130)
	sw t1153, (t1150)
L28	addi t1156, r0, 0
	lw t1158, ~4(t130)
	addi t1159, r0, 1
	sub t1157, t1158, t1159
	jal t1155
	sw t1154, (t1149)
	mult t1160, t1150, t1149
	sw t1160, (t174)
L31:
	j L353
L29:
	addi t1161, r0, 1
	sw t1161, (t174)
	j L31
L353:
L355:
malloc	addi t1164, r0, 8
	jal t1163
	sw t1162, (t154)
L20	sw t1165, 0 (t154)
	addi t1166, r0, 1000
	sw t1166, 4 (t154)
	sw t154, (t155)
	lw t1167, ~4(t130)
	j L354
L354:
L20: .asciiz "Nobody"L357:
initArray	addi t1170, r0, 10
	addi t1171, r0, 0
	jal t1169
	sw t1168, (t140)
	addi t1172, r0, 0
	sw t1172, (t141)
	lw t1173, ~4(t130)
	j L356
L356:
L359:
initArray	addi t1176, r0, 10
	addi t1177, r0, 0
	jal t1175
	sw t1174, (t132)
	addi t1178, r0, 0
	sw t1178, (t133)
	lw t1179, ~4(t130)
	j L358
L358:
