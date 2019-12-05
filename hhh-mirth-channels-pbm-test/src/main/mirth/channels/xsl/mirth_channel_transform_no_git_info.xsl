<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:param name="channelName"/>
  <xsl:param name="channelDescriptionFile"/>
  <xsl:param name="groupId"/>
  <xsl:param name="artifactId"/>

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>

  <!--  Identity transform -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/channel/description">
    <description>
      <!-- <xsl:value-of select='replace(.,"(.*)__BEGIN_BUILD_INFO__.*__END_BUILD_INFO__(.*)", "$1$2", "sm")'/> -->
<xsl:value-of select='replace(unparsed-text($channelDescriptionFile, "iso-8859-1"),"(.*)@BEGIN-BUILD-INFO@.*@END-BUILD-INFO@.*", "$1", "sm")' disable-output-escaping='yes'/>
    </description>
  </xsl:template>

</xsl:stylesheet>