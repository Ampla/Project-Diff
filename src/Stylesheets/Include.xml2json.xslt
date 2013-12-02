<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	>

	
	<xsl:template match='*' mode='json'>
		<xsl:param name='indent'/>
		<xsl:value-of select="concat($indent, '{ ', $quote, name(), $quote, ' :', $crlf)"/>
		<xsl:value-of select="concat($indent, $space, '{', $crlf)"/>	
		
		<!-- Attributes -->
		<xsl:apply-templates select='@*' mode='json'>
			<xsl:with-param name='indent' select="concat($indent, $space)"/>
			<xsl:sort select='name()'/>
		</xsl:apply-templates>
			
		<!-- Property -->
		<xsl:value-of select="concat($indent, $space, $quote, 'Property', $quote, ' :', $crlf)"/>
		<xsl:value-of select="concat($indent, $space, $space, '{', $crlf)"/>	
			<xsl:apply-templates select='Property' mode='json'>
				<xsl:with-param name='indent' select="concat($indent, $space, $space)"/>
				<xsl:sort select='@name'/>
			</xsl:apply-templates>
		<xsl:value-of select="concat($indent, $space, $space, '}', $crlf)"/>	
		
		<!-- Item -->
		<xsl:if test='Item'>
			<xsl:value-of select="concat($indent, $space, $quote, 'Item', $quote, ' :', $crlf)"/>
			<xsl:value-of select="concat($indent, $space, $space, '[', $crlf)"/>	
				<xsl:apply-templates select='Item' mode='json'>
					<xsl:with-param name='indent' select="concat($indent, $space, $space)"/>
					<xsl:sort select='@name'/>
				</xsl:apply-templates>
			<xsl:value-of select="concat($indent, $space, $space, ']', $crlf)"/>	
		</xsl:if>
		
		<xsl:value-of select="concat($indent, $space, '}', $crlf)"/>
		
		<xsl:value-of select="concat($indent, '}', $crlf)"/>
	</xsl:template>
	
	<xsl:template match='@*' mode='json'>
		<xsl:param name='indent'/>
		<xsl:variable name='inc-comma'>
			<xsl:if test='position() &lt; last()'>, </xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat($indent, $quote, name(), $quote, ' : ', $quote, ., $quote, $inc-comma, $crlf)"/>
	</xsl:template>
	
	<xsl:template match='Item/Property[(count(./child::*) + count(@*)) = 1]' mode='json'>
		<xsl:param name='indent'/>
		<xsl:variable name='inc-comma'>
			<xsl:if test='position() &lt; last()'>, </xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat($indent, $quote, @name, $quote, ' : ', $quote, ., $quote, $inc-comma, $crlf)"/>
	</xsl:template>
	
	<xsl:template match='Item/Property' mode='json'>
		<xsl:param name='indent'/>
		<xsl:value-of select="concat($indent, $quote, @name, $quote, ' : ', $crlf)"/>
		<xsl:value-of select="concat($indent, $space, '{ ', $crlf)"/>
			<xsl:apply-templates select="." mode="detect">
				<xsl:with-param name='indent' select="concat($indent, $space, $space)"/>
				<xsl:sort select='@name'/>
			</xsl:apply-templates>
		<xsl:value-of select="concat($indent, $space, '} ', $crlf)"/>
	</xsl:template>
		
	<xsl:template match="*" mode="detect">
		<xsl:param name='indent'/>
		<xsl:choose>
			<xsl:when test="name(preceding-sibling::*[1]) = name(current()) and name(following-sibling::*[1]) != name(current())">
				<xsl:apply-templates select="." mode="obj-content" />
				<xsl:variable name='inc-comma'>
					<xsl:if test='count(following-sibling::*[name() != name(current())]) &gt; 0'>, </xsl:if>
				</xsl:variable>
				<xsl:value-of select="concat($indent, '] ', $inc-comma, $crlf)"/>
			</xsl:when>
			<xsl:when test="name(preceding-sibling::*[1]) = name(current())">
				<xsl:apply-templates select="." mode="obj-content">
					<xsl:with-param name='indent' select="concat($indent, $space)"/>
					<xsl:sort select='@name'/>
				</xsl:apply-templates>
				<xsl:if test="name(following-sibling::*) = name(current())">, </xsl:if>
			</xsl:when>
			<xsl:when test="following-sibling::*[1][name() = name(current())]">
				<xsl:text>"</xsl:text><xsl:value-of select="name()"/><xsl:text>" : [</xsl:text>
				<xsl:apply-templates select="." mode="obj-content">
					<xsl:with-param name='indent' select="concat($indent, $space)"/>
					<xsl:sort select='@name'/>
				</xsl:apply-templates>
				<xsl:variable name='inc-comma'>,</xsl:variable>
				<xsl:value-of select="concat($indent, $inc-comma, $crlf)"/>
			</xsl:when>
			<xsl:when test="count(./child::*) > 0 or count(@*) > 0">
				<xsl:text>"</xsl:text><xsl:value-of select="name()"/>" : <xsl:apply-templates select="." mode="obj-content" />
				<xsl:if test="count(following-sibling::*) &gt; 0">, </xsl:if>
			</xsl:when>
			<xsl:when test="count(./child::*) = 0">
				<xsl:text>"</xsl:text><xsl:value-of select="name()"/>" : "<xsl:apply-templates select="."/><xsl:text>"</xsl:text>
				<xsl:if test="count(following-sibling::*) &gt; 0">, </xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="*" mode="obj-content">
		<xsl:param name='indent'/>
		<xsl:value-of select="concat($indent, $space, '{', $crlf)"/>	
		<xsl:apply-templates select="@*" mode="json">
			<xsl:with-param name='indent' select="concat($indent, $space, $space)"/>
			<xsl:sort select='@name'/>
		</xsl:apply-templates>
		<xsl:if test="count(@*) &gt; 0 and (count(child::*) &gt; 0 or text())">, </xsl:if>
		<xsl:apply-templates select="./*" mode="detect" />
		<xsl:if test="count(child::*) = 0 and text() and not(@*)">
			<xsl:text>"</xsl:text><xsl:value-of select="name()"/>" : "<xsl:value-of select="text()"/><xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:if test="count(child::*) = 0 and text() and @*">
			<xsl:text>"text" : "</xsl:text><xsl:value-of select="text()"/><xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:variable name='inc-comma'>
			<xsl:if test='position() &lt; last()'>, </xsl:if>
		</xsl:variable>
		<xsl:value-of select="concat($indent, $space, '}', $inc-comma, $crlf)"/>	
	</xsl:template>
	
</xsl:stylesheet>
