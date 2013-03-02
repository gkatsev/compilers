L456:
	addi t1528, r0, 0
	j L455
L455:
L454:
	lw t1529, ~4(t130)
	j L457
L457:
L453:
	lw t1530, ~4(t130)
	j L458
L458:
L460:
	addi t1531, r0, 4
	sw t1531, (t1354)
	j L459
L459:
L462:
	addi t1532, r0, 0
	sw t1532, (t1180)
	lw t1533, ~4(t130)
	addi t1534, r0, 0
	beq t1533, t1534, L361
L464:
	j L362
L463:
	lw t1535, ~4(t130)
	addi t1536, r0, 0
	bne t1535, t1536, L363
L465:
	j L364
L461:
L467:
	addi t1537, r0, 0
	sw t1537, (t1012)
	addi t1538, r0, 0
	sw t1538, ~4 (t130)
	j L466
L466:
L469:
malloc	addi t1542, r0, 8
	jal t1541
	sw t1540, (t845)
L283	sw t1543, 0 (t845)
	addi t1544, t845, 4
	sw t1544, (t1539)
initArray	addi t1547, r0, 3
	addi t1548, r0, 1900
	jal t1546
	sw t1545, (t844)
	addi t1549, r0, 0
	sw t1549, (t1539)
	sw t845, (t846)
malloc	addi t1552, r0, 16
	jal t1551
	sw t1550, (t842)
L281	sw t1553, 0 (t842)
L282	sw t1554, 4 (t842)
	addi t1555, r0, 2432
	sw t1555, 8 (t842)
	addi t1556, r0, 44
	sw t1556, 12 (t842)
	sw t842, (t843)
initArray	addi t1559, r0, 100
L280	jal t1558
	sw t1557, (t840)
	addi t1561, r0, 0
	sw t1561, (t841)
malloc	addi t1564, r0, 16
	jal t1563
	sw t1562, (t837)
L278	sw t1565, 0 (t837)
L279	sw t1566, 4 (t837)
	addi t1567, r0, 0
	sw t1567, 8 (t837)
	addi t1568, r0, 0
	sw t1568, 12 (t837)
initArray	addi t1571, r0, 5
	jal t1570
	sw t1569, (t838)
	addi t1572, r0, 0
	sw t1572, (t839)
initArray	addi t1575, r0, 10
	addi t1576, r0, 0
	jal t1574
	sw t1573, (t835)
	addi t1577, r0, 0
	sw t1577, (t836)
	addi t1578, r0, 1
	lw t1580, ~4(t130)
	addi t1582, r0, 4
	addi t1583, r0, 0
	mult t1581, t1582, t1583
	add t1579, t1580, t1581
	sw t1578, (t1579)
	addi t1584, r0, 3
	lw t1586, ~4(t130)
	addi t1588, r0, 4
	addi t1589, r0, 9
	mult t1587, t1588, t1589
	add t1585, t1586, t1587
	sw t1584, (t1585)
L284	addi t1591, r0, 0
	sw t1590, (t1591)
	addi t1592, r0, 23
	addi t1593, r0, 0
	sw t1592, (t1593)
L285	lw t1596, ~4(t130)
	addi t1598, r0, 4
	addi t1599, r0, 34
	mult t1597, t1598, t1599
	add t1595, t1596, t1597
	sw t1594, (t1595)
L286	lw t1601, ~4(t130)
	sw t1600, 0 (t1601)
	addi t1602, r0, 2323
	lw t1605, ~4(t130)
	lw t1604, 4(t1605)
	addi t1607, r0, 4
	addi t1608, r0, 0
	mult t1606, t1607, t1608
	add t1603, t1604, t1606
	sw t1602, (t1603)
	addi t1609, r0, 2323
	lw t1612, ~4(t130)
	lw t1611, 4(t1612)
	addi t1614, r0, 4
	addi t1615, r0, 2
	mult t1613, t1614, t1615
	add t1610, t1611, t1613
	sw t1609, (t1610)
	j L468
L468:
L286: .asciiz "sdf"L285: .asciiz "sfd"L284: .asciiz "kati"L283: .asciiz "Allos"L282: .asciiz "Kapou"L281: .asciiz "Kapoios"L280: .asciiz ""L279: .asciiz "somewhere"L278: .asciiz "aname"L471:
	addi t1616, r0, 0
	j L470
L470:
L473:
L211	sw t1617, (t659)
	addi t1618, r0, 0
	sw t1618, (t657)
	j L472
L472:
L211: .asciiz " "L475:
initArray	addi t1621, r0, 10
	addi t1622, r0, 0
	jal t1620
	sw t1619, (t569)
	addi t1623, r0, 0
	sw t1623, (t570)
	lw t1626, ~4(t130)
	addi t1628, r0, 4
	addi t1629, r0, 2
	mult t1627, t1628, t1629
	add t1625, t1626, t1627
	lw t1624, 0(t1625)
	j L474
L474:
L477:
	addi t1630, r0, 0
	sw t1630, (t494)
L152	addi t1632, r0, 0
	addi t1633, r0, 2
	jal t1631
	j L476
L476:
L152:
	lw t1634, ~4(t130)
	j L478
L478:
L480:
	addi t1635, r0, 0
	sw t1635, (t420)
	addi t1636, r0, 0
	sw t1636, (t422)
	addi t1637, r0, 100
	sw t1637, (t423)
	addi t1638, r0, 0
	addi t1639, r0, 100
	ble t1638, t1639, L125
L124:
	j L479
L125:
	lw t1641, ~4(t130)
	addi t1640, t1641, 1
	sw t1640, ~4 (t130)
	addi t1642, t422, 1
	sw t1642, (t422)
L126:
	ble t422, t423, L125
L481:
	j L124
L479:
L483:
	addi t1643, r0, 10
	addi t1644, r0, 20
	bgt t1643, t1644, L99
L100:
	addi t1645, r0, 40
	sw t1645, (t358)
L101:
	j L482
L99:
	addi t1646, r0, 30
	sw t1646, (t358)
	j L101
L482:
L485:
L74	addi t1648, r0, 0
L78	addi t1650, r0, 0
	jal t1647
	j L484
L484:
L78: .asciiz "str2"L75:
L74	addi t1652, r0, 0
L76	lw t1654, ~4(t130)
	jal t1651
L77	j L486
L486:
L77: .asciiz " "L76: .asciiz "str"L74:
	j L487
L487:
L489:
L54	addi t1657, r0, 0
L57	addi t1659, r0, 0
	jal t1656
	j L488
L488:
L57: .asciiz "str2"L55:
L54	addi t1661, r0, 0
L56	lw t1663, ~4(t130)
	jal t1660
	j L490
L490:
L56: .asciiz "str"L54:
	j L491
L491:
L493:
malloc	addi t1666, r0, 8
	jal t1665
	sw t1664, (t209)
	addi t1667, r0, 0
	sw t1667, 0 (t209)
	addi t1668, r0, 0
	sw t1668, 4 (t209)
	sw t209, (t210)
	lw t1669, ~4(t130)
	j L492
L492:
L495:
L28	addi t1671, r0, 0
	addi t1672, r0, 10
	jal t1670
	j L494
L494:
L28:
	lw t1675, ~4(t130)
	addi t1676, r0, 0
	beq t1675, t1676, L29
L30:
	lw t1677, ~4(t130)
	sw t1677, (t1674)
L28	addi t1680, r0, 0
	lw t1682, ~4(t130)
	addi t1683, r0, 1
	sub t1681, t1682, t1683
	jal t1679
	sw t1678, (t1673)
	mult t1684, t1674, t1673
	sw t1684, (t174)
L31:
	j L496
L29:
	addi t1685, r0, 1
	sw t1685, (t174)
	j L31
L496:
L498:
malloc	addi t1688, r0, 8
	jal t1687
	sw t1686, (t154)
L20	sw t1689, 0 (t154)
	addi t1690, r0, 1000
	sw t1690, 4 (t154)
	sw t154, (t155)
	lw t1691, ~4(t130)
	j L497
L497:
L20: .asciiz "Nobody"L500:
initArray	addi t1694, r0, 10
	addi t1695, r0, 0
	jal t1693
	sw t1692, (t140)
	addi t1696, r0, 0
	sw t1696, (t141)
	lw t1697, ~4(t130)
	j L499
L499:
L502:
initArray	addi t1700, r0, 10
	addi t1701, r0, 0
	jal t1699
	sw t1698, (t132)
	addi t1702, r0, 0
	sw t1702, (t133)
	lw t1703, ~4(t130)
	j L501
L501:
