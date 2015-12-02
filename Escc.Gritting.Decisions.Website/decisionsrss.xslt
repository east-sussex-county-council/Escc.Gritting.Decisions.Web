<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
    xmlns:decisions="http://www.eastsussex.gov.uk/EsccWebTeam.Gritting"
>
  <xsl:output method="xml" indent="yes"/>
  <xsl:include href="\inetpub\wwwroot\masterpages\rss\dates.xslt"/>
  <xsl:include href="\inetpub\wwwroot\masterpages\rss\rss-utilities.xslt"/>

  <!-- Require the current date in two formats: RFC 822 for display in RSS feed, and ISO 8601 for numeric comparison of dates. 
         Doing numeric comparison of dates because .NET only supports XPath 1.0 and XPath 1.0 doesn't understand dates. -->
  <xsl:param name="Rfc822Date" />

  <!-- Links to HTML version, and the current feed-->
  <xsl:param name="HtmlVersionUrl" />
  <xsl:param name="CurrentUrl" />

  <!-- Transform begins here, by writing out the header of the RSS feed. Assumes feed will be hosted on www.eastsussex.gov.uk -->
  <xsl:template match="/">
    <xsl:call-template name="HtmlFormatting">
      <xsl:with-param name="CurrentUrl" select="$CurrentUrl" />
    </xsl:call-template>
    <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
      <channel>

        <!-- Create the RSS channel header -->
        <xsl:call-template name="ChannelHeader">
          <xsl:with-param name="Title">Road maintenance decisions - East Sussex County Council</xsl:with-param>
          <xsl:with-param name="Description">Decisions about whether to grit or plough on primary and secondary routes across East Sussex.</xsl:with-param>
          <xsl:with-param name="CurrentUrl" select="$CurrentUrl" />
          <xsl:with-param name="HtmlVersionUrl" select="$HtmlVersionUrl" />
          <xsl:with-param name="Rfc822Date" select="$Rfc822Date" />
        </xsl:call-template>
        
        <!-- Now process the decisions -->
        <xsl:apply-templates select="decisions:ArrayOfGrittingDecision/decisions:GrittingDecision" />
      </channel>
    </rss>
  </xsl:template>

  <xsl:template match="decisions:GrittingDecision">
    <xsl:variable name="ActionAt">
      <xsl:if test="decisions:ActionTime != ''">
        at  <xsl:call-template name="HouseStyleTime">
          <xsl:with-param name="Date" select="decisions:ActionTime" />
        </xsl:call-template>
      </xsl:if>
    </xsl:variable>

    <item>
      <!-- We can put almost all the information into the title -->
      <title>
        <xsl:value-of select="decisions:RouteSet/decisions:RouteSetName"/>: <xsl:value-of select="decisions:Action"/> <xsl:value-of select="$ActionAt"/>
      </title>

      <!-- Link to the most appropriate page, which is the list of decisions -->
      <link>
        <xsl:value-of select="$HtmlVersionUrl"/>
      </link>

      <!-- Use decision date as published date for the item -->
      <pubDate>
        <xsl:call-template name="ISO8601DatetoRFC822Date">
          <xsl:with-param name="Date" select="decisions:DecisionTime" />
        </xsl:call-template>
      </pubDate>

      <!-- Use the linked data URI of the decision to identify it in the RSS feed -->
      <guid isPermaLink="false">
        <xsl:value-of select="decisions:LinkedDataUri"/>
      </guid>

      <!-- Add the URL of the current feed -->
      <xsl:if test="$CurrentUrl != ''">
        <source>
          <xsl:attribute xmlns="http://www.w3.org/2001/XMLSchema" name="url">
            <xsl:value-of select="$CurrentUrl"/>
          </xsl:attribute>
        </source>
      </xsl:if>

      <!-- Offer the route as a filter -->
      <category>
        <xsl:value-of select="decisions:RouteSet/decisions:RouteSetName"/>
      </category>

      <!-- Offer the action as a filter -->
      <category>
        <xsl:value-of select="decisions:Action"/>
      </category>
    </item>
  </xsl:template>
</xsl:stylesheet>
