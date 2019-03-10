<#
.Synopsis
    Returns a list of episodes in a feed
.DESCRIPTION
    Returns a list of episodes in a feed, given the feed-url or the xml-data.
.EXAMPLE
    Get-PodcastInfo
#>
function Get-PodcastEpisodes {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true, Position = 0, ParameterSetName = "url")]
        [Alias("xmlURL")]
        [string] $url,
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Mandatory = $true, Position = 0, ParameterSetName = "xml")]
        [xml] $FeedXml
    )
    
    Begin {}
    Process {
        if ($PSCmdlet.ParameterSetName -eq "url") {      
            [xml]$FeedXml = (Invoke-WebRequest -Uri $url).Content
        } 
        foreach ($item in $FeedXml.rss.channel.item) {
            
            $pubdate = [DateTime]::Parse($item.pubdate)
            
            [Episode]$outobject = [Episode]::new()
            $outobject.title = $item.title
            $outobject.guid = $item.guid.InnerText
            $outobject.url = $item.selectNodes("link").InnerText
            $outobject.enclosure = $item.enclosure.url
            $outobject.duration = $item.duration
            $outobject.pubdate = $pubdate
            $outobject.episode = [int]$item.episode
            $outobject.season = [int]$item.season
            $outobject.episodeType = $item.episodeType
            $outobject.imgURL = $item.image.href
            $outobject.subtitle = $item.subtitle
            $outobject.summary = $item.summary
            $outobject.description = $item.description.InnerText
            $outobject.descriptionHTML = $item.encoded.InnerText
            $outobject.chapters = $item.chapters.chapter
            $outobject.rawdata = $item
            
            $outobject
        }
    }
    End {}
}

Export-ModuleMember Get-PodcastEpisodes