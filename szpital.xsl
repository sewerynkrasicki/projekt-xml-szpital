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
		<h4><a href="szpital.xml"><xsl:text>Zobacz pełną strukture szpitala tutaj</xsl:text></a></h4>
		<xsl:comment>Skrócona struktura szpitala</xsl:comment>
		<section>
			<table class="firstTable">
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
							<xsl:if test="@plec='m'">
								<p class='m'><xsl:value-of select="concat(imie, ' ', nazwisko)"></xsl:value-of></p>
							</xsl:if>
							<xsl:if test="@plec='k'">
								<p class='k'><xsl:value-of select="concat(imie, ' ', nazwisko)"></xsl:value-of></p>
							</xsl:if>
							<br></br>
						</xsl:for-each>
					</td>
				</tr>
				<tr>
					<xsl:for-each select="pacjenci/pacjent">
					</xsl:for-each>
				</tr>
			</table>
			<h1><xsl:text>Sprzęt</xsl:text></h1>
			<xsl:comment>Struktura sprzętu</xsl:comment>
			<table class="secondTable">
				<tr>
					<td>
						<b><xsl:text>Ilość karetek</xsl:text></b>
					</td>
					<td>
						<xsl:value-of select="count(karetki/karetka)"/>
					</td>
				</tr>
				<tr>
					<td>
						<b><xsl:text>Ilość oddziałów</xsl:text></b>
					</td>
					<td>
						<xsl:value-of select="count(oddzialy/oddzial)"/>
					</td>
				</tr>
				<tr>
					<td>
						<b><xsl:text>Sprzęt medyczny według ilości</xsl:text></b>
					</td>
					<td>
						<xsl:for-each select="środki_ochrony/środek_ochrony">
							<xsl:sort select="ilość" order="descending"/>
								<xsl:value-of select="nazwa"></xsl:value-of>
								<xsl:text> Ilość: </xsl:text>
								<xsl:value-of select="ilość"></xsl:value-of>
								<br></br>
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