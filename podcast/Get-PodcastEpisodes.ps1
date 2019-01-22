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

            $outobject = [PSCustomObject]@{
                PSTypeName = 'PodShell.Episode'
                title = $item.title
                guid = $item.guid.InnerText
                url = $item.selectNodes("link").InnerText
                enclosure = $item.enclosure.url
                duration = $item.duration
                pubdate =  $pubdate
                episode = [int]$item.episode
                season = [int]$item.season
                episodeType = $item.episodeType
                imgURL = $item.image.href
                subtitle = $item.subtitle
                summary = $item.summary
                description = $item.description.InnerText
                descriptionHTML = $item.encoded.InnerText
                chapters = $item.chapters.chapter
                rawdata = $item
            }
            $outobject
        }
    }
    End {}
}

Export-ModuleMember Get-PodcastEpisodes