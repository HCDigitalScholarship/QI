<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
  <xsl:output omit-xml-declaration="yes" method="xhtml" indent="yes"/>


  <xsl:template match="/">
    <body>
      <xsl:apply-templates select="tei:TEI/tei:text" />
    </body>
  </xsl:template>


  <!-- Transform <head>. -->
  <xsl:template match="tei:head">
    <h4>
      <xsl:apply-templates/>
    </h4>
  </xsl:template>
<!-- transform <div type="xxx">-->


  <!-- Transform <p>. -->
  <xsl:template match="tei:p">
    <p class="tei-text">
      <xsl:apply-templates/>
    </p>
  </xsl:template>


  <!-- Transform <lb>. -->
  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>

  <!-- Transform <persName>, <orgName>, <placeName> -->
  <xsl:template match="tei:persName">
    <a class="persName" id="Per-popover-{position()}" data-toggle="popover" data-trigger="focus" data-html="true" title="Person Information" data-content="No information">
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="@key" />
      </xsl:attribute>
        <xsl:apply-templates/>
    </a>
  </xsl:template>
  
  <xsl:template match="tei:orgName">
    <a class="orgName" id="Org-popover-{position()}" data-toggle="popover" data-trigger="fcours" data-html="true" title="Orgnization Information" data-content="Oops" data-placement="right">
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="@key" />
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
 
  
  <xsl:template match="tei:placeName">
    <a class="placeName"  id="Pla-popover-{position()}" data-html= "true" data-toggle="popover" data-trigger="fcours" title="Place Information" data-content="Oops" data-placement="right">
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="@key" />
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>


  <!-- Preserve these (without the TEI namespace). -->
  <xsl:template match="tei:pb|tei:div">
    <xsl:element name="{local-name()}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>


  <!-- The namespace on xml:id has to be eliminated. -->
  <xsl:template match="tei:div[@xml:id]">
    <div>
      <xsl:attribute name="id">
        <xsl:value-of select="@xml:id" />
      </xsl:attribute>
      <xsl:apply-templates/>
    </div>
  </xsl:template>


  <!-- Ignore these but copy their contents. -->
  <xsl:template match="tei:pc|tei:i|tei:fw|tei:emph|tei:u|tei:hi|tei:gap|tei:text|tei:choice|tei:ref|tei:front|tei:body|tei:back|tei:g|tei:c|tei:add|tei:foreign">
    <xsl:apply-templates/>
  </xsl:template>


  <!-- Catch unmatched nodes (courtesy of stackoverflow.com/questions/3360017/). -->
  <xsl:template match="*">
    <xsl:message>STYLESHEET WARNING: unmatched element <xsl:value-of select="name()"/></xsl:message>
    <xsl:apply-templates/>
  </xsl:template>
</xsl:stylesheet>
