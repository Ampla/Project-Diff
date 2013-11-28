<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	>
		
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
