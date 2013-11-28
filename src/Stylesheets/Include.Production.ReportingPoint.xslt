<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    >

  <xsl:template match="Item[@type='Citect.Ampla.Production.Server.ProductionReportingPoint']" mode="output-file">
	<xsl:value-of select="concat('Production\', @fullName, '.xml')"/>
  </xsl:template>

  <xsl:template match="Item[@type='Citect.Ampla.Production.Server.ProductionReportingPoint']" mode="output" >
	<xsl:param name='filename'/>
    <xsl:param name="this-file">Include.Production.ReportingPoint.xslt</xsl:param>
    <xsl:comment>Generated by: <xsl:value-of select="$this-file"/></xsl:comment>
	<xsl:apply-templates select='.' mode='copy'/>
  </xsl:template>
  
</xsl:stylesheet>