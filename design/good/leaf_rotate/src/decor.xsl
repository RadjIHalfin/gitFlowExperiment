<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:svg="http://www.w3.org/2000/svg"
		exclude-result-prefixes="svg">

    <xsl:output encoding="utf-8" method="xml" indent="yes" 
		omit-xml-declaration="no" cdata-section-elements="svg:style"/>

    <xsl:param name="decor" select="''"/>
    <xsl:param name="leaf_src_name"/>

    <xsl:template match="/svg:svg">
	<xsl:copy>
	    <xsl:copy-of select="@*"/>

	    <xsl:choose>
	        <xsl:when test="$decor=''">
		    <xsl:variable name="decor_file" select="concat($leaf_src_name, '_decor.svg')"/>
		    <xsl:copy-of select="document($decor_file)/svg:svg/*"/>
	        </xsl:when>
	        <xsl:otherwise>
		    <xsl:variable name="decor_file" select="concat($leaf_src_name, '_decor_', $decor, '.svg')"/>
		    <xsl:copy-of select="document($decor_file)/svg:svg/*"/>
	        </xsl:otherwise>
	    </xsl:choose>
	
	    <xsl:variable name="leaf_form_file" select="concat($leaf_src_name, '_form.svg')"/>
	    <xsl:copy-of select="document($leaf_form_file)/svg:svg/svg:defs"/>

	    <xsl:copy-of select="svg:defs"/>

	    <xsl:copy-of select="document('logo_leaf_rotate_show.svg')/svg:svg/*"/>

	</xsl:copy>
    </xsl:template>

    <xsl:template match="*">
	<xsl:copy>
	    <xsl:copy-of select="@*"/>
	    <xsl:apply-templates/>
	</xsl:copy>
    </xsl:template>  

    <xsl:template match="text()">
	<xsl:value-of select="."/>
    </xsl:template>

</xsl:stylesheet>