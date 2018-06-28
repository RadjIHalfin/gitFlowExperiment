<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text" indent="no" cdata-section-elements="text" />
  <xsl:strip-space elements="*"/>

  <xsl:param name="programName" select="'TEST.exe'"/>

  <!-- можно указать название опции предваряя префиксом -->
  <xsl:param name="commandName" select="'logo'"/>

  <xsl:variable name="command" select="/ParametersSchema/commands/command[@argName = $commandName]"/>

  <xsl:variable name="optionPrefix" select="/ParametersSchema/commandLineSyntax/optionToken/@prefix"/>
  <xsl:variable name="optionName">
     <xsl:if test="substring($commandName, 1, 1) = $optionPrefix">
       <xsl:value-of select="substring($commandName, 2)"/>       
    </xsl:if>
  </xsl:variable>
  <xsl:variable name="option" select="/ParametersSchema/options/option[@argName = $optionName]"/>

  <!-- строгое начало -->
  <xsl:template match="/">
    <xsl:apply-templates select="/ParametersSchema/commands/command"/>
    <xsl:apply-templates select="/ParametersSchema/options/option"/>
  </xsl:template>

  <xsl:template match="/ParametersSchema/commands/command">
    <xsl:if test="@id = $command/@id">
      <xsl:apply-templates select ="$command/description[@type = 'common']"/>
      <!-- вставляется перевод строки (\n, то есть пара #13 #10) -->
      <xsl:text disable-output-escaping="yes">&#10;</xsl:text>
      <xsl:apply-templates select ="$command/description[@type = 'usage']"/>
    </xsl:if>
  </xsl:template>

    <xsl:template match="/ParametersSchema/options/option">
    <xsl:if test="@id = $option/@id">
      <xsl:apply-templates select ="$option/description[@type = 'common']"/>
      <!-- вставляется перевод строки (\n, то есть пара #13 #10) -->
      <xsl:text disable-output-escaping="yes">&#10;</xsl:text>
      <xsl:apply-templates select ="$option/description[@type = 'usage']"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="description[@type = 'common']">
    <xsl:apply-templates select ="node()"/>
  </xsl:template>
  <xsl:template match="description[@type = 'usage']">
    <xsl:apply-templates select ="node()"/>
  </xsl:template>

  <xsl:template match="line">
    <!-- вставляется текст в новой строке. (перевод строки = \n, то есть пара из #13 #10) -->
    <xsl:apply-templates select ="node()"/>
    <xsl:text disable-output-escaping="yes">&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="tab">
    <!-- символ табуляции (8 пробелов) -->
    <xsl:text disable-output-escaping="yes">&#x9;</xsl:text>
  </xsl:template>

  <xsl:template match="space">
    <!-- пробел -->
    <xsl:text disable-output-escaping="yes">&#x20;</xsl:text>
  </xsl:template>

  <xsl:template match="text">
    <xsl:value-of select ="text()"/>
  </xsl:template>

  <xsl:template match="runtimeValue">
    <xsl:choose>
      <xsl:when test="@name = 'programName'">
        <xsl:value-of select="$programName"/>
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
    <!-- получаем табличку со списком и кратким описанием команд -->
    <xsl:for-each select="/ParametersSchema/commands/command">
      <xsl:text disable-output-escaping="yes">&#x9;</xsl:text>
      <!--xsl:value-of select="@argName"/-->

      <!-- делаем паддинг названия команды до 16 сисволов -->
      <xsl:value-of select="substring(concat(@argName, '                '), 1, 16)"/>

      <!-- символ табуляции (8 пробелов) -->
      <xsl:text disable-output-escaping="yes">&#x9;</xsl:text>
      <xsl:copy-of select="description[@type = 'short']/node()"/>
      <!-- вставляется перевод строки (\n, то есть пара #13 #10) -->
      <xsl:text disable-output-escaping="yes">&#10;</xsl:text>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template match="xsltValue[@name = 'optionsWithDescriptions']">
    <!-- получаем табличку со списком и кратким описанием опций -->
    <xsl:for-each select="/ParametersSchema/options/option">
      <xsl:text disable-output-escaping="yes">&#x9;</xsl:text>
      <!--xsl:value-of select="@argName"/-->

      <!-- делаем паддинг названия опции до 16 сисволов -->
      <xsl:value-of select="substring(concat(@argName, '                '), 1, 16)"/>

      <!-- символ табуляции (8 пробелов) -->
      <xsl:text disable-output-escaping="yes">&#x9;</xsl:text>
      <xsl:copy-of select="description[@type = 'short']/node()"/>
      <!-- вставляется перевод строки (\n, то есть пара #13 #10) -->
      <xsl:text disable-output-escaping="yes">&#10;</xsl:text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="xsltValue[@name = 'commandName']">
    <!-- получаем имя команды на месте ссылки  <xsltValue name="commandName" ref="тут id команды"/> -->
    <xsl:value-of select="/ParametersSchema/commands/command[@id = current()/@ref]/@argName"/>
  </xsl:template>

  <xsl:template match="xsltValue[@name = 'optionSyntax']">
    <!-- получаем синтаксис опции  <xsltValue name="optionSyntax" ref="тут id опции"/> -->
    <!--Пока берем описание только из общего описания опции. То что описано в команде игнорируем.-->
    <!--Пока не учитываем возможность указания или отсутствия значения у опции.-->

    <xsl:variable name="commonOption" select="/ParametersSchema/options/option[@id = current()/@ref]"/>
    <xsl:variable name="commandOption" select="/ParametersSchema/commands/command[node() = current()/parent::node()]/optionRef[@ref = current()/@ref]"/>

    <xsl:if test="@minOccurs = 0">
      <xsl:text>[</xsl:text>
    </xsl:if>

    <xsl:value-of select="/ParametersSchema/commandLineSyntax/optionToken/@prefix"/>
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="$commonOption/@argName"/>
    <xsl:text>&gt;</xsl:text>
    <xsl:text>[</xsl:text>
    <xsl:value-of select="/ParametersSchema/commandLineSyntax/optionToken/@valuePrefix"/>
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="/ParametersSchema/commandLineSyntax/optionToken/@valueTitle"/>
    <xsl:text>&gt;</xsl:text>
    <xsl:text>]</xsl:text>

    <xsl:if test="@minOccurs='0'">
      <xsl:text>]</xsl:text>
    </xsl:if>
  </xsl:template>


<!-- ======================================================================== -->  
<!-- далее всякая системная дребедень для предсказуемой работы трансворматора -->
<!-- ======================================================================== -->  

<!-- стандарнтый шаблон для копирования элементов с аттрибутами -->
  <!--  
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
-->


  <!-- по умолчанию действует такой шаблон -->
  <!-- он копирует весь необработанный текст и аттрибуты -->
  <!--
  <xsl:template match="text()|@*">
    <xsl:value-of select="."/>
  </xsl:template>
-->
  <!-- перехватим его как ошибку -->
  <xsl:template match="text()|@*" priority="-9">
    <xsl:text>WARNING: Unexpected Text or Attribute "</xsl:text>
    <xsl:value-of select="name()"/>
    <!--/xsl:message -->
    <!-- стопнем обработку -->
    <xsl:message terminate="yes"/>
  </xsl:template>

  
  <!-- по умолчанию действует такой шаблон -->
  <!-- он обрабатывает подэлементы корня и в текущего элемента -->
  <!--
  <xsl:template match="*|/">
    <xsl:apply-templates/>
  </xsl:template>  
-->
  <!-- перехватим его как ошибку -->
  
  <!-- Шаблон для перехвата необработанных тегов. Если он сработал, то надо что-то предпринять. -->
  <!-- Он работает с наименьшим приориттетом, чтобы не мешать другим -->
  <xsl:template match="/" priority="-9">
    <xsl:text>WARNING: Template for Root Element undefined</xsl:text>
    <!-- стопнем обработку -->
    <xsl:message terminate="yes"/>
  </xsl:template>

  <xsl:template match="*" priority="-9">
    <!-- Какой-то баг. Текста мессажа не видно. -->
    <!-- xsl:message terminate="no" -->
    <xsl:text>WARNING: Template for Element "</xsl:text>
    <xsl:value-of select="name()"/>
    <xsl:text>" undefineded</xsl:text>
    <!--/xsl:message -->
    <!-- стопнем обработку -->
    <xsl:message terminate="yes"/>
  </xsl:template>

</xsl:stylesheet>
