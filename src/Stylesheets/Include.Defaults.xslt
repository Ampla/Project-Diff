﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	>
	
	<xsl:variable name="comma" select="','"/>
	<xsl:variable name="crlf" select="'&#xD;&#xA;'"/>
	<xsl:variable name="cr" select="'&#xD;'"/>
	<xsl:variable name="quote">"</xsl:variable>
	<xsl:variable name="space" select="'    '"/>
	
	<!-- default template to include files -->
	<xsl:template match='*' mode='output-file'>
		<!-- Return the filename here for the file --> 
	</xsl:template>
	
	<!-- default template to include files -->
	<xsl:template match='*' mode='output-mode'>
		<!-- Return 'xml,text,html' to control the output mode --> 
		<xsl:text>xml</xsl:text>
	</xsl:template>
	
	<xsl:template match='*' mode='copy'>
		<xsl:copy>
			<xsl:apply-templates select='@*' mode='copy'>
				<xsl:sort select='name()'/>
			</xsl:apply-templates>
			<xsl:apply-templates select='node()' mode='copy'>
				<xsl:sort select='@name'/>
			</xsl:apply-templates>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match='@*' mode='copy'>
		<xsl:copy/>
	</xsl:template>
	
</xsl:stylesheet>
