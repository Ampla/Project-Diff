<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    >

  <xsl:template match="Item[@type='Citect.Ampla.Metrics.Server.MetricsReportingPoint']" mode="output-file">
	<xsl:value-of select="concat('Metrics\', @fullName, '.json')"/>
  </xsl:template>

  <xsl:template match="Item[@type='Citect.Ampla.Metrics.Server.MetricsReportingPoint']" mode="output-mode">text</xsl:template>

  <xsl:template match="Item[@type='Citect.Ampla.Metrics.Server.MetricsReportingPoint']" mode="output" >
	<xsl:param name='filename'/>
    <xsl:param name="this-file">Include.Metrics.ReportingPoint.xslt</xsl:param>
	<xsl:apply-templates select='.' mode='json'/>
  </xsl:template>
  
</xsl:stylesheet>
