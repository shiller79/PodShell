function GetAtomLinks {
    param (
        [xml]$FeedXml
        )
        
        $Namespace = @{atom="http://www.w3.org/2005/Atom";
                bitlove="http://bitlove.org";
                itunes="http://www.itunes.com/dtds/podcast-1.0.dtd";
                psc="http://podlove.org/simple-chapters";
                content="http://purl.org/rss/1.0/modules/content/";
                fh="http://purl.org/syndication/history/1.0" ;
                feedpress="https://feed.press/xmlns"}

        $RssLinks = Select-Xml -Xml $FeedXml -XPath "//rss/channel/atom:link" -Namespace $Namespace
        foreach ($RssLink in $RssLinks)
    {
        $RssLink.Node
    }
}


<#
.Synopsis
    Returns information about a podcast.
.DESCRIPTION
    Returns information about a podcast, given the feed-url or the xml-data.
.EXAMPLE
    Get-PodcastInfo
#>
function Get-PodcastInfo {
	[CmdletBinding()]
	param (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true, Position=0,ParameterSetName="url")]
        [Alias("xmlUrl")]
        [string] $url,
        [Parameter(ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true, Mandatory=$true, Position=0,ParameterSetName="xml")]
        [xml] $FeedXml
        )
        
        Begin {
        $Namespace = @{atom="http://www.w3.org/2005/Atom";
                bitlove="http://bitlove.org";
                itunes="http://www.itunes.com/dtds/podcast-1.0.dtd";
                psc="http://podlove.org/simple-chapters";
                content="http://purl.org/rss/1.0/modules/content/";
                fh="http://purl.org/syndication/history/1.0" ;
                feedpress="https://feed.press/xmlns"}
        }

        Process {
            if ($PSCmdlet.ParameterSetName -eq "url") {      
                [xml]$FeedXml = (Invoke-WebRequest -Uri $url).Content
            } 
            $channel = $FeedXml.rss.channel
            
            # if there is an itunes:description then use that, otherwise use subtitel
            if ([string]::IsNullOrWhiteSpace($channel.description)) {
                $subtitle = $channel.subtitle
            } else {
                $subtitle = $channel.description
            }
            
            #get Atom links
            $AtomLinks = Select-Xml -Xml $FeedXml -XPath "//rss/channel/atom:link" -Namespace $Namespace
            foreach ($AtomLink in $AtomLinks)
            {
                if ($AtomLink.Node.rel -eq "self") { $xmlURL = $AtomLink.Node.href }
            }
            

            #parse pubDate fom pubdate or from lastBuilddate
            $pubdate = New-Object datetime
            if (-not [string]::IsNullOrWhiteSpace($channel.pubDate)) {  
                try { $pubdate = [DateTime]::Parse($channel.pubDate) }  catch  {Write-Verbose "Error parsing pubdate"} 
            }
            elseif (-not [string]::IsNullOrWhiteSpace($channel.lastBuildDate)) {
                try { $pubdate = [DateTime]::Parse($channel.lastBuildDate) }  catch  {Write-Verbose "Error parsing lastBuildDate"}
            } 

            $outobject = [PSCustomObject]@{
                PSTypeName = 'PodShell.Podcast'
                Title = (Select-Xml -Xml $FeedXml -XPath "/rss/channel/title" -Namespace $Namespace).Node.InnerText
                Subtitle = $subtitle
                Summary = (Select-Xml -Xml $FeedXml -XPath "/rss/channel/summary" -Namespace $Namespace).Node.InnerText
                ImgUrl = (Select-Xml -Xml $FeedXml -XPath "/rss/channel/image/url" -Namespace $Namespace).Node.InnerText
                XmlUrl = (Select-Xml -Xml $FeedXml -XPath '/rss/channel/atom:link[@rel="self"]' -Namespace $Namespace).Node.href.InnerText
                HtmlUrl = (Select-Xml -Xml $FeedXml -XPath "/rss/channel/link" -Namespace $Namespace).Node.InnerText
                FirstUrl = (Select-Xml -Xml $FeedXml -XPath '/rss/channel/atom:link[@rel="first"]' -Namespace $Namespace).Node.href.InnerText
                NextUrl = (Select-Xml -Xml $FeedXml -XPath '/rss/channel/atom:link[@rel="next"]' -Namespace $Namespace).Node.href.InnerText
                PreviousUrl = (Select-Xml -Xml $FeedXml -XPath '/rss/channel/atom:link[@rel="next"]' -Namespace $Namespace).Node.href.InnerText
                LastUrl = (Select-Xml -Xml $FeedXml -XPath '/rss/channel/atom:link[@rel="last"]' -Namespace $Namespace).Node.href.InnerText

                Language = (Select-Xml -Xml $FeedXml -XPath "/rss/channel/language" -Namespace $Namespace).Node.InnerText
                Generator = (Select-Xml -Xml $FeedXml -XPath "/rss/channel/generator" -Namespace $Namespace).Node.InnerText
                PubDate =  $pubdate
                rawdata = $channel
            }
            
            return $outobject
        }
        End { }
}

Export-ModuleMember Get-PodcastInfo