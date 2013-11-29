<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    >

  <xsl:template match="Item[@type='Citect.Ampla.Isa95.EquipmentClassDefinition']" mode="output-file">
	  <xsl:value-of select="concat('Class\', @fullName, '.txt')"/>
  </xsl:template>
  
  <xsl:template match="Item[@type='Citect.Ampla.Isa95.EquipmentClassDefinition']" mode="output-mode">text</xsl:template>

  <xsl:template match="Item[@type='Citect.Ampla.Isa95.EquipmentClassDefinition']" mode="output" >
	<xsl:param name='filename'/>
	<xsl:apply-templates select='.' mode='json'/>
  </xsl:template>
  
</xsl:stylesheet>
