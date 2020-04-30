<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" encoding="UTF-8"/>

<xsl:template match="szpital">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Language" content="pl" />
		<title>Szpital</title>
	</head>
	<body>
		<header><h1>Szpital</h1></header>
		<xsl:comment>Mała baza danych szpitala</xsl:comment>
		<section>
			<table>
				<tr>
					<td>
						<b>Liczba wszystkich pracowników</b>
					</td>
					<td>
						<xsl:value-of select="count(pracownicy/lekarze/lekarz)
						+count(pracownicy/pielegniarki/pielegniarka)
						+count(pracownicy/ratownicy_medyczni/ratownik)"/>
					</td>
				</tr>
				<tr>
					<td>
						<b>Liczba lekarzy</b>
					</td>
					<td>
						<xsl:value-of select="count(pracownicy/lekarze/lekarz)"/>
					</td>
				</tr>
				<tr>
					<td>
						<b>Liczba pielęgniarek</b>
					</td>
					<td>
						<xsl:value-of select="count(pracownicy/pielegniarki/pielegniarka)"/>
					</td>
				</tr>
				<tr>
					<td>
						<b>Liczba ratowników</b>
					</td>
					<td>
						<xsl:value-of select="count(pracownicy/ratownicy_medyczni/ratownik)"/>
					</td>
				</tr>
				<tr>
					<td>
						<b>Liczba pacjentów</b>
					</td>
					<td>
						<xsl:value-of select="count(pacjenci/pacjent)"/>
					</td>
				</tr>
				<tr>
					<td>
						<b>Średnia liczba zarobków pracowników</b>
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
						<b>Dostepni ratownicy</b>
					</td>
					<td>
						<xsl:value-of select="count(pracownicy/ratownicy_medyczni/ratownik[dostepnosc='TAK'])"/>
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