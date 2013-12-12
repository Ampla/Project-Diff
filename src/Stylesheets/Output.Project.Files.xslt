<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:exsl="http://exslt.org/common"
				extension-element-prefixes="exsl"				
				>

	<xsl:output method="xml" indent="yes"/>
	
	<xsl:include href='Include.Defaults.xslt'/>
	<xsl:include href='Include.xml2json.xslt'/>
	
	<xsl:include href='Include.Project.Properties.xslt'/>
	<xsl:include href='Include.Code.xslt'/>
	<xsl:include href='Include.Data.Repository.xslt'/>
	<xsl:include href='Include.Class.Equipment.xslt'/>
	<xsl:include href='Include.Class.Material.xslt'/>
	<xsl:include href='Include.Class.Personnel.xslt'/>
	<xsl:include href='Include.Production.ReportingPoint.xslt'/>
	<xsl:include href='Include.Downtime.ReportingPoint.xslt'/>
	<xsl:include href='Include.Quality.ReportingPoint.xslt'/>
	<xsl:include href='Include.Planning.ReportingPoint.xslt'/>
	<xsl:include href='Include.Maintenance.ReportingPoint.xslt'/>
	<xsl:include href='Include.Metrics.ReportingPoint.xslt'/>
	<xsl:include href='Include.Reference.Type.xslt'/>
	<xsl:include href='Include.User.Details.xslt'/>
	<xsl:include href='Include.Actions.xslt'/>
	
	<xsl:template match="/">
		<xsl:element name="Output">
			<xsl:for-each select="//*">
				<xsl:variable name='filename'>
					<xsl:apply-templates select='.' mode='output-file'/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="string-length($filename) > 0">
						<xsl:variable name='method'>
							<xsl:apply-templates select='.' mode='output-mode'/>
						</xsl:variable>
						<File name='{$filename}' format='{$method}'/>
						<xsl:choose>
							<xsl:when test="$method='xml'">
								<exsl:document href="{$filename}" method="{$method}" indent="yes">
									<xsl:apply-templates select='.' mode='output'>
										<xsl:with-param name='filename' select='$filename'/>
									</xsl:apply-templates>
								</exsl:document>
							</xsl:when>
							<xsl:otherwise>
								<exsl:document href="{$filename}" method="{$method}" >
									<xsl:apply-templates select='.' mode='output'>
										<xsl:with-param name='filename' select='$filename'/>
									</xsl:apply-templates>
								</exsl:document>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
			
</xsl:stylesheet>
