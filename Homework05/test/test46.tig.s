L366:
	addi t1181, r0, 0
	sw t1181, (t1180)
	lw t1182, ~4(t130)
	addi t1183, r0, 0
	beq t1182, t1183, L361
L368:
	j L362
L367:
	lw t1184, ~4(t130)
	addi t1185, r0, 0
	bne t1184, t1185, L363
L369:
	j L364
L365:
L371:
	addi t1186, r0, 0
	sw t1186, (t1012)
	addi t1187, r0, 0
	sw t1187, ~4 (t130)
	j L370
L370:
L373:
malloc	addi t1191, r0, 8
	jal t1190
	sw t1189, (t845)
L283	sw t1192, 0 (t845)
	addi t1193, t845, 4
	sw t1193, (t1188)
initArray	addi t1196, r0, 3
	addi t1197, r0, 1900
	jal t1195
	sw t1194, (t844)
	addi t1198, r0, 0
	sw t1198, (t1188)
	sw t845, (t846)
malloc	addi t1201, r0, 16
	jal t1200
	sw t1199, (t842)
L281	sw t1202, 0 (t842)
L282	sw t1203, 4 (t842)
	addi t1204, r0, 2432
	sw t1204, 8 (t842)
	addi t1205, r0, 44
	sw t1205, 12 (t842)
	sw t842, (t843)
initArray	addi t1208, r0, 100
L280	jal t1207
	sw t1206, (t840)
	addi t1210, r0, 0
	sw t1210, (t841)
malloc	addi t1213, r0, 16
	jal t1212
	sw t1211, (t837)
L278	sw t1214, 0 (t837)
L279	sw t1215, 4 (t837)
	addi t1216, r0, 0
	sw t1216, 8 (t837)
	addi t1217, r0, 0
	sw t1217, 12 (t837)
initArray	addi t1220, r0, 5
	jal t1219
	sw t1218, (t838)
	addi t1221, r0, 0
	sw t1221, (t839)
initArray	addi t1224, r0, 10
	addi t1225, r0, 0
	jal t1223
	sw t1222, (t835)
	addi t1226, r0, 0
	sw t1226, (t836)
	addi t1227, r0, 1
	lw t1229, ~4(t130)
	addi t1231, r0, 4
	addi t1232, r0, 0
	mult t1230, t1231, t1232
	add t1228, t1229, t1230
	sw t1227, (t1228)
	addi t1233, r0, 3
	lw t1235, ~4(t130)
	addi t1237, r0, 4
	addi t1238, r0, 9
	mult t1236, t1237, t1238
	add t1234, t1235, t1236
	sw t1233, (t1234)
L284	addi t1240, r0, 0
	sw t1239, (t1240)
	addi t1241, r0, 23
	addi t1242, r0, 0
	sw t1241, (t1242)
L285	lw t1245, ~4(t130)
	addi t1247, r0, 4
	addi t1248, r0, 34
	mult t1246, t1247, t1248
	add t1244, t1245, t1246
	sw t1243, (t1244)
L286	lw t1250, ~4(t130)
	sw t1249, 0 (t1250)
	addi t1251, r0, 2323
	lw t1254, ~4(t130)
	lw t1253, 4(t1254)
	addi t1256, r0, 4
	addi t1257, r0, 0
	mult t1255, t1256, t1257
	add t1252, t1253, t1255
	sw t1251, (t1252)
	addi t1258, r0, 2323
	lw t1261, ~4(t130)
	lw t1260, 4(t1261)
	addi t1263, r0, 4
	addi t1264, r0, 2
	mult t1262, t1263, t1264
	add t1259, t1260, t1262
	sw t1258, (t1259)
	j L372
L372:
L286: .asciiz "sdf"L285: .asciiz "sfd"L284: .asciiz "kati"L283: .asciiz "Allos"L282: .asciiz "Kapou"L281: .asciiz "Kapoios"L280: .asciiz ""L279: .asciiz "somewhere"L278: .asciiz "aname"L375:
	addi t1265, r0, 0
	j L374
L374:
L377:
L211	sw t1266, (t659)
	addi t1267, r0, 0
	sw t1267, (t657)
	j L376
L376:
L211: .asciiz " "L379:
initArray	addi t1270, r0, 10
	addi t1271, r0, 0
	jal t1269
	sw t1268, (t569)
	addi t1272, r0, 0
	sw t1272, (t570)
	lw t1275, ~4(t130)
	addi t1277, r0, 4
	addi t1278, r0, 2
	mult t1276, t1277, t1278
	add t1274, t1275, t1276
	lw t1273, 0(t1274)
	j L378
L378:
L381:
	addi t1279, r0, 0
	sw t1279, (t494)
L152	addi t1281, r0, 0
	addi t1282, r0, 2
	jal t1280
	j L380
L380:
L152:
	lw t1283, ~4(t130)
	j L382
L382:
L384:
	addi t1284, r0, 0
	sw t1284, (t420)
	addi t1285, r0, 0
	sw t1285, (t422)
	addi t1286, r0, 100
	sw t1286, (t423)
	addi t1287, r0, 0
	addi t1288, r0, 100
	ble t1287, t1288, L125
L124:
	j L383
L125:
	lw t1290, ~4(t130)
	addi t1289, t1290, 1
	sw t1289, ~4 (t130)
	addi t1291, t422, 1
	sw t1291, (t422)
L126:
	ble t422, t423, L125
L385:
	j L124
L383:
L387:
	addi t1292, r0, 10
	addi t1293, r0, 20
	bgt t1292, t1293, L99
L100:
	addi t1294, r0, 40
	sw t1294, (t358)
L101:
	j L386
L99:
	addi t1295, r0, 30
	sw t1295, (t358)
	j L101
L386:
L389:
L74	addi t1297, r0, 0
L78	addi t1299, r0, 0
	jal t1296
	j L388
L388:
L78: .asciiz "str2"L75:
L74	addi t1301, r0, 0
L76	lw t1303, ~4(t130)
	jal t1300
L77	j L390
L390:
L77: .asciiz " "L76: .asciiz "str"L74:
	j L391
L391:
L393:
L54	addi t1306, r0, 0
L57	addi t1308, r0, 0
	jal t1305
	j L392
L392:
L57: .asciiz "str2"L55:
L54	addi t1310, r0, 0
L56	lw t1312, ~4(t130)
	jal t1309
	j L394
L394:
L56: .asciiz "str"L54:
	j L395
L395:
L397:
malloc	addi t1315, r0, 8
	jal t1314
	sw t1313, (t209)
	addi t1316, r0, 0
	sw t1316, 0 (t209)
	addi t1317, r0, 0
	sw t1317, 4 (t209)
	sw t209, (t210)
	lw t1318, ~4(t130)
	j L396
L396:
L399:
L28	addi t1320, r0, 0
	addi t1321, r0, 10
	jal t1319
	j L398
L398:
L28:
	lw t1324, ~4(t130)
	addi t1325, r0, 0
	beq t1324, t1325, L29
L30:
	lw t1326, ~4(t130)
	sw t1326, (t1323)
L28	addi t1329, r0, 0
	lw t1331, ~4(t130)
	addi t1332, r0, 1
	sub t1330, t1331, t1332
	jal t1328
	sw t1327, (t1322)
	mult t1333, t1323, t1322
	sw t1333, (t174)
L31:
	j L400
L29:
	addi t1334, r0, 1
	sw t1334, (t174)
	j L31
L400:
L402:
malloc	addi t1337, r0, 8
	jal t1336
	sw t1335, (t154)
L20	sw t1338, 0 (t154)
	addi t1339, r0, 1000
	sw t1339, 4 (t154)
	sw t154, (t155)
	lw t1340, ~4(t130)
	j L401
L401:
L20: .asciiz "Nobody"L404:
initArray	addi t1343, r0, 10
	addi t1344, r0, 0
	jal t1342
	sw t1341, (t140)
	addi t1345, r0, 0
	sw t1345, (t141)
	lw t1346, ~4(t130)
	j L403
L403:
L406:
initArray	addi t1349, r0, 10
	addi t1350, r0, 0
	jal t1348
	sw t1347, (t132)
	addi t1351, r0, 0
	sw t1351, (t133)
	lw t1352, ~4(t130)
	j L405
L405:
