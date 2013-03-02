L409:
	addi t1355, r0, 4
	sw t1355, (t1354)
	j L408
L408:
L411:
	addi t1356, r0, 0
	sw t1356, (t1180)
	lw t1357, ~4(t130)
	addi t1358, r0, 0
	beq t1357, t1358, L361
L413:
	j L362
L412:
	lw t1359, ~4(t130)
	addi t1360, r0, 0
	bne t1359, t1360, L363
L414:
	j L364
L410:
L416:
	addi t1361, r0, 0
	sw t1361, (t1012)
	addi t1362, r0, 0
	sw t1362, ~4 (t130)
	j L415
L415:
L418:
malloc	addi t1366, r0, 8
	jal t1365
	sw t1364, (t845)
L283	sw t1367, 0 (t845)
	addi t1368, t845, 4
	sw t1368, (t1363)
initArray	addi t1371, r0, 3
	addi t1372, r0, 1900
	jal t1370
	sw t1369, (t844)
	addi t1373, r0, 0
	sw t1373, (t1363)
	sw t845, (t846)
malloc	addi t1376, r0, 16
	jal t1375
	sw t1374, (t842)
L281	sw t1377, 0 (t842)
L282	sw t1378, 4 (t842)
	addi t1379, r0, 2432
	sw t1379, 8 (t842)
	addi t1380, r0, 44
	sw t1380, 12 (t842)
	sw t842, (t843)
initArray	addi t1383, r0, 100
L280	jal t1382
	sw t1381, (t840)
	addi t1385, r0, 0
	sw t1385, (t841)
malloc	addi t1388, r0, 16
	jal t1387
	sw t1386, (t837)
L278	sw t1389, 0 (t837)
L279	sw t1390, 4 (t837)
	addi t1391, r0, 0
	sw t1391, 8 (t837)
	addi t1392, r0, 0
	sw t1392, 12 (t837)
initArray	addi t1395, r0, 5
	jal t1394
	sw t1393, (t838)
	addi t1396, r0, 0
	sw t1396, (t839)
initArray	addi t1399, r0, 10
	addi t1400, r0, 0
	jal t1398
	sw t1397, (t835)
	addi t1401, r0, 0
	sw t1401, (t836)
	addi t1402, r0, 1
	lw t1404, ~4(t130)
	addi t1406, r0, 4
	addi t1407, r0, 0
	mult t1405, t1406, t1407
	add t1403, t1404, t1405
	sw t1402, (t1403)
	addi t1408, r0, 3
	lw t1410, ~4(t130)
	addi t1412, r0, 4
	addi t1413, r0, 9
	mult t1411, t1412, t1413
	add t1409, t1410, t1411
	sw t1408, (t1409)
L284	addi t1415, r0, 0
	sw t1414, (t1415)
	addi t1416, r0, 23
	addi t1417, r0, 0
	sw t1416, (t1417)
L285	lw t1420, ~4(t130)
	addi t1422, r0, 4
	addi t1423, r0, 34
	mult t1421, t1422, t1423
	add t1419, t1420, t1421
	sw t1418, (t1419)
L286	lw t1425, ~4(t130)
	sw t1424, 0 (t1425)
	addi t1426, r0, 2323
	lw t1429, ~4(t130)
	lw t1428, 4(t1429)
	addi t1431, r0, 4
	addi t1432, r0, 0
	mult t1430, t1431, t1432
	add t1427, t1428, t1430
	sw t1426, (t1427)
	addi t1433, r0, 2323
	lw t1436, ~4(t130)
	lw t1435, 4(t1436)
	addi t1438, r0, 4
	addi t1439, r0, 2
	mult t1437, t1438, t1439
	add t1434, t1435, t1437
	sw t1433, (t1434)
	j L417
L417:
L286: .asciiz "sdf"L285: .asciiz "sfd"L284: .asciiz "kati"L283: .asciiz "Allos"L282: .asciiz "Kapou"L281: .asciiz "Kapoios"L280: .asciiz ""L279: .asciiz "somewhere"L278: .asciiz "aname"L420:
	addi t1440, r0, 0
	j L419
L419:
L422:
L211	sw t1441, (t659)
	addi t1442, r0, 0
	sw t1442, (t657)
	j L421
L421:
L211: .asciiz " "L424:
initArray	addi t1445, r0, 10
	addi t1446, r0, 0
	jal t1444
	sw t1443, (t569)
	addi t1447, r0, 0
	sw t1447, (t570)
	lw t1450, ~4(t130)
	addi t1452, r0, 4
	addi t1453, r0, 2
	mult t1451, t1452, t1453
	add t1449, t1450, t1451
	lw t1448, 0(t1449)
	j L423
L423:
L426:
	addi t1454, r0, 0
	sw t1454, (t494)
L152	addi t1456, r0, 0
	addi t1457, r0, 2
	jal t1455
	j L425
L425:
L152:
	lw t1458, ~4(t130)
	j L427
L427:
L429:
	addi t1459, r0, 0
	sw t1459, (t420)
	addi t1460, r0, 0
	sw t1460, (t422)
	addi t1461, r0, 100
	sw t1461, (t423)
	addi t1462, r0, 0
	addi t1463, r0, 100
	ble t1462, t1463, L125
L124:
	j L428
L125:
	lw t1465, ~4(t130)
	addi t1464, t1465, 1
	sw t1464, ~4 (t130)
	addi t1466, t422, 1
	sw t1466, (t422)
L126:
	ble t422, t423, L125
L430:
	j L124
L428:
L432:
	addi t1467, r0, 10
	addi t1468, r0, 20
	bgt t1467, t1468, L99
L100:
	addi t1469, r0, 40
	sw t1469, (t358)
L101:
	j L431
L99:
	addi t1470, r0, 30
	sw t1470, (t358)
	j L101
L431:
L434:
L74	addi t1472, r0, 0
L78	addi t1474, r0, 0
	jal t1471
	j L433
L433:
L78: .asciiz "str2"L75:
L74	addi t1476, r0, 0
L76	lw t1478, ~4(t130)
	jal t1475
L77	j L435
L435:
L77: .asciiz " "L76: .asciiz "str"L74:
	j L436
L436:
L438:
L54	addi t1481, r0, 0
L57	addi t1483, r0, 0
	jal t1480
	j L437
L437:
L57: .asciiz "str2"L55:
L54	addi t1485, r0, 0
L56	lw t1487, ~4(t130)
	jal t1484
	j L439
L439:
L56: .asciiz "str"L54:
	j L440
L440:
L442:
malloc	addi t1490, r0, 8
	jal t1489
	sw t1488, (t209)
	addi t1491, r0, 0
	sw t1491, 0 (t209)
	addi t1492, r0, 0
	sw t1492, 4 (t209)
	sw t209, (t210)
	lw t1493, ~4(t130)
	j L441
L441:
L444:
L28	addi t1495, r0, 0
	addi t1496, r0, 10
	jal t1494
	j L443
L443:
L28:
	lw t1499, ~4(t130)
	addi t1500, r0, 0
	beq t1499, t1500, L29
L30:
	lw t1501, ~4(t130)
	sw t1501, (t1498)
L28	addi t1504, r0, 0
	lw t1506, ~4(t130)
	addi t1507, r0, 1
	sub t1505, t1506, t1507
	jal t1503
	sw t1502, (t1497)
	mult t1508, t1498, t1497
	sw t1508, (t174)
L31:
	j L445
L29:
	addi t1509, r0, 1
	sw t1509, (t174)
	j L31
L445:
L447:
malloc	addi t1512, r0, 8
	jal t1511
	sw t1510, (t154)
L20	sw t1513, 0 (t154)
	addi t1514, r0, 1000
	sw t1514, 4 (t154)
	sw t154, (t155)
	lw t1515, ~4(t130)
	j L446
L446:
L20: .asciiz "Nobody"L449:
initArray	addi t1518, r0, 10
	addi t1519, r0, 0
	jal t1517
	sw t1516, (t140)
	addi t1520, r0, 0
	sw t1520, (t141)
	lw t1521, ~4(t130)
	j L448
L448:
L451:
initArray	addi t1524, r0, 10
	addi t1525, r0, 0
	jal t1523
	sw t1522, (t132)
	addi t1526, r0, 0
	sw t1526, (t133)
	lw t1527, ~4(t130)
	j L450
L450:
