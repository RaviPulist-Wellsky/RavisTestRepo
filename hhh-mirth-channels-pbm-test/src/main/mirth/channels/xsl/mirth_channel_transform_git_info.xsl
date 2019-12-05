<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:param name="channelName"/>
  <xsl:param name="channelDescriptionFile"/>
  <xsl:param name="groupId"/>
  <xsl:param name="artifactId"/>
  <xsl:param name="gitBranch"/>
  <xsl:param name="gitBuildVersion"/>
  <xsl:param name="gitBuildTime"/>
  <xsl:param name="gitBuildHost"/>
  <xsl:param name="gitBuildUserName"/>
  <xsl:param name="gitBuildUserEmail"/>
  <xsl:param name="gitRemoteOriginUrl"/>
  <xsl:param name="gitDirty"/>
  <xsl:param name="gitCommitId"/>
  <xsl:param name="gitCommitTime"/>
  <xsl:param name="gitCommitUserName"/>
  <xsl:param name="gitCommitUserEmail"/>
  <xsl:param name="gitCommitIdDescribeShort"/>
  <xsl:param name="gitCommitMessageShort"/>
  <xsl:param name="gitCommitTags"/>
  <xsl:param name="gitTotalCommitCount"/>


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

__BEGIN_BUILD_INFO__
Maven Artifact Info: <xsl:value-of select="$groupId"/>:<xsl:value-of select="$artifactId"/>:<xsl:value-of select="$gitBuildVersion"/>
Branch: <xsl:value-of select="$gitBranch"/>
Build Version: <xsl:value-of select="$gitBuildVersion"/>
Build Time: <xsl:value-of select="$gitBuildTime"/>
Build Host: <xsl:value-of select="$gitBuildHost"/>
Build User Name: <xsl:value-of select="$gitBuildUserName"/>
Build User Email: <xsl:value-of select="$gitBuildUserEmail"/>
Git Repo Url: <xsl:value-of select="$gitRemoteOriginUrl"/>
Git Dirty: <xsl:value-of select="$gitDirty"/>
Git Commit Hash: <xsl:value-of select="$gitCommitId"/>
Git Commit Describe: <xsl:value-of select="$gitCommitIdDescribeShort"/>
Git Commit Time: <xsl:value-of select="$gitCommitTime"/>
Git Commit User Name: <xsl:value-of select="$gitCommitUserName"/>
Git Commit User Email: <xsl:value-of select="$gitCommitUserEmail"/>
Git Commit Message (Short): <xsl:value-of select="$gitCommitMessageShort"/>
Git Tags: <xsl:value-of select="$gitCommitTags"/>
Git Total Commit Count: <xsl:value-of select="$gitTotalCommitCount"/>
__END_BUILD_INFO__
    </description>
  </xsl:template>


  <xsl:template match="text()">
    <xsl:analyze-string select='.' regex='^\s*var channelBuildId\s*=?.*$' flags="m">
      <xsl:matching-substring>var channelBuildId = &apos;<xsl:value-of select="$groupId"/>:<xsl:value-of select="$artifactId"/>:<xsl:value-of select="$gitBuildVersion"/>&apos;;</xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:analyze-string select='.' regex='^\s*var channelBuildVersion\s*=?.*$' flags="m">
          <xsl:matching-substring>var channelBuildVersion = &apos;<xsl:value-of select="$gitBuildVersion"/>&apos;;</xsl:matching-substring>
          <xsl:non-matching-substring>
            <xsl:value-of select="."/>
          </xsl:non-matching-substring>
        </xsl:analyze-string>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:template>

</xsl:stylesheet>