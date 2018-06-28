<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="programName" select="'TEST.exe'"/>
    
  <xsl:template match="description|usage">
    <xsl:copy>
      <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
      <xsl:apply-templates select ="node()"/>
      <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="runtimeValue">
    <xsl:choose>
      <xsl:when test="@name = 'programName'">
        <xsl:value-of select="$programName"/>;
      </xsl:when>
    
    </xsl:choose>
   </xsl:template>
    
  <xsl:template match="xsltValue[@name = 'commandLineSyntax']">
    <xsl:for-each select="/ParametersSchema/commandLineSyntax/*">
      <xsl:choose>
        <xsl:when test="name()='commandToken'">
          <xsl:call-template name="comLineToken"/>
        </xsl:when>
        <xsl:when test="name()='optionToken'">
          <xsl:call-template name="optionToken"/>
        </xsl:when>
        <xsl:when test="name()='paramToken'">
          <xsl:call-template name="comLineToken"/>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="comLineToken">
    <xsl:text> </xsl:text>
    <xsl:if test="@minOccurs = 0">
      <xsl:text>[</xsl:text>
    </xsl:if>

    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="@title"/>
    <xsl:text>&gt;</xsl:text>

    <xsl:if test="@maxOccurs &gt; 1 or @maxOccurs = 'unbounded'">
      <xsl:text> [</xsl:text>
      <xsl:if test="@maxOccurs &gt; 2 or @maxOccurs = 'unbounded'">
        <xsl:text> ... </xsl:text>
      </xsl:if>
      <xsl:text>&lt;</xsl:text>
      <xsl:value-of select="@title"/>
      <xsl:text>&gt;</xsl:text>
      <xsl:text>]</xsl:text>
    </xsl:if>

    <xsl:if test="@minOccurs='0'">
      <xsl:text>]</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="optionToken">
    <xsl:text> </xsl:text>
    <xsl:if test="@minOccurs = 0">
      <xsl:text>[</xsl:text>
    </xsl:if>

    <xsl:value-of select="@prefix"/>
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="@title"/>
    <xsl:text>&gt;</xsl:text>
    <xsl:text>[</xsl:text>
    <xsl:value-of select="@valuePrefix"/>
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="@valueTitle"/>
    <xsl:text>&gt;</xsl:text>
    <xsl:text>]</xsl:text>

    <xsl:if test="@maxOccurs &gt; 1 or @maxOccurs = 'unbounded'">
      <xsl:text> [</xsl:text>
      <xsl:if test="@maxOccurs &gt; 2 or @maxOccurs = 'unbounded'">
        <xsl:text> ... </xsl:text>
      </xsl:if>
      <xsl:value-of select="@prefix"/>
      <xsl:text>&lt;</xsl:text>
      <xsl:value-of select="@title"/>
      <xsl:text>&gt;</xsl:text>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="@valuePrefix"/>
      <xsl:text>&lt;</xsl:text>
      <xsl:value-of select="@valueTitle"/>
      <xsl:text>&gt;</xsl:text>
      <xsl:text>]</xsl:text>
      <xsl:text>]</xsl:text>
    </xsl:if>

    <xsl:if test="@minOccurs='0'">
      <xsl:text>]</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="xsltValue[@name = 'commandsWithDescriptions']">
    <xsl:for-each select="/ParametersSchema/commands/command">

    <xsl:text disable-output-escaping="yes">
</xsl:text> <!-- вставляется #13 #10 -->
      <xsl:value-of select="@argName"/>
    
    <xsl:text disable-output-escaping="yes">       </xsl:text> <!-- имитация Табуляции (8 пробелов) -->

    <xsl:copy-of select="description/node()"/>
    </xsl:for-each>
  </xsl:template>

  
    <!-- получаемимя команды на месте ссылки  <commandRef ref="тут id команды"/> -->
  <xsl:template match="/ParametersSchema//*[self::usage | self::description]/commandRef">
    <xsl:value-of select="/ParametersSchema/commands/command[@id = current()/@ref]/@argName"/>
  </xsl:template>

  <xsl:template match="br">
    <xsl:text disable-output-escaping="yes">
</xsl:text> <!-- вставляется #13 #10 -->
  </xsl:template>
  <xsl:template match="tab">
    <xsl:text disable-output-escaping="yes">       </xsl:text> <!-- имитация Табуляции (8 пробелов) -->
  </xsl:template>

    
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
