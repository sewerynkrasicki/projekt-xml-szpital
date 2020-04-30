<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" encoding="UTF-8"/>

<xsl:template match="szpital">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Language" content="pl" />
		<title>Szpital</title>
	</head>
	<body>
		<header><h1><xsl:text>Szpital</xsl:text></h1></header>
		<xsl:comment>Mała baza danych szpitala</xsl:comment>
		<section>
			<table>
				<tr>
					<td>
						<b><xsl:text>Liczba wszystkich pracowników</xsl:text></b>
					</td>
					<td>
						<xsl:value-of select="count(pracownicy/lekarze/lekarz)
						+count(pracownicy/pielegniarki/pielegniarka)
						+count(pracownicy/ratownicy_medyczni/ratownik)"/>
					</td>
				</tr>
				<tr>
					<td>
						<b><xsl:text>Liczba lekarzy</xsl:text></b>
					</td>
					<td>
						<xsl:value-of select="count(pracownicy/lekarze/lekarz)"/>
					</td>
				</tr>
				<tr>
					<td>
						<b><xsl:text>Liczba pielęgniarek</xsl:text></b>
					</td>
					<td>
						<xsl:value-of select="count(pracownicy/pielegniarki/pielegniarka)"/>
					</td>
				</tr>
				<tr>
					<td>
						<b><xsl:text>Liczba ratowników</xsl:text></b>
					</td>
					<td>
						<xsl:value-of select="count(pracownicy/ratownicy_medyczni/ratownik)"/>
					</td>
				</tr>
				<tr>
					<td>
						<b><xsl:text>Liczba pacjentów</xsl:text></b>
					</td>
					<td>
						<xsl:value-of select="count(pacjenci/pacjent)"/>
					</td>
				</tr>
				<tr>
					<td>
						<b><xsl:text>Średnia liczba zarobków pracowników</xsl:text></b>
					</td>
					<td>
						<xsl:value-of select="format-number(((sum(pracownicy/lekarze/lekarz/pensja)
						+sum(pracownicy/pielegniarki/pielegniarka/pensja)
						+sum(pracownicy/ratownicy_medyczni/ratownik/pensja)) div 
						(count(pracownicy/lekarze/lekarz)
						+count(pracownicy/pielegniarki/pielegniarka)
						+count(pracownicy/ratownicy_medyczni/ratownik))), '0.00')"/>
					</td>
				</tr>
				<tr>
					<td>
						<b><xsl:text>Dostepni ratownicy</xsl:text></b>
					</td>
					<td>
						<xsl:for-each select="pracownicy/ratownicy_medyczni/ratownik[dostepnosc='TAK']">
							<xsl:value-of select="concat(imie, ' ', nazwisko)"></xsl:value-of>
							<br></br>
						</xsl:for-each>
					</td>
				</tr>
				<tr>
					<td>
						<b><xsl:text>Sprzęt medyczny według ilości</xsl:text></b>
					</td>
					<td>
						<xsl:for-each select="środki_ochrony/środek_ochrony">
							<xsl-sort select="ilość" order="descending">
								<xsl:value-of select="nazwa"></xsl:value-of>
								<xsl:text> Ilość: </xsl:text>
								<xsl-value-of select="ilość"></xsl-value-of>
							</xsl-sort>
						</xsl:for-each>
					</td>
				</tr>
			</table>
		</section>
		<footer>
			<p><b>Seweryn Krasicki 2020 &#169;</b></p>
		</footer>
	</body>
</xsl:template>
</xsl:stylesheet>