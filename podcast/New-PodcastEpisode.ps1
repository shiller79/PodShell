<#
.Synopsis
    Creates a new Episode-Object
.DESCRIPTION
    Creates a new Episode-Object
.EXAMPLE
    New-PodcastEpisode -Title "New Episode" -Enclosure "https://exampel.com/download/episode001.mp3"
#>
function New-PodcastEpisode {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [string] $Title,
        [Parameter(Position = 1)]
        [string]$Guid = [guid]::NewGuid(),
        [Parameter(Position = 2)]
        [string]$Url,
        [Parameter(Position = 3)]
        [string]$Enclosure,
        [Parameter(Position = 4)]
        [string]$Duration,
        [Parameter(Position = 5)]
        [datetime]$PubDate = (Get-Date),
        [Parameter(Position = 6)]
        [int]$Episode,
        [Parameter(Position = 7)]
        [int]$Season,
        [Parameter(Position = 8)]
        [string]$EpisodeType,
        [Parameter(Position = 9)]
        [string]$imgURL,
        [Parameter(Position = 10)]
        [string]$Subtitle,
        [Parameter(Position = 11)]
        [string]$Summary,
        [Parameter(Position = 12)]
        [string]$Description,
        [Parameter(Position = 13)]
        [string]$DescriptionHTML
    )
    
    Begin {}
    Process {

        [Episode]$outobject = [Episode]::new()
        $outobject.title = $Title
        $outobject.guid = $Guid
        $outobject.url = $Url
        $outobject.enclosure = $Enclosure
        $outobject.duration = $Duration
        $outobject.pubdate = $PubDate
        $outobject.episode = $Episode
        $outobject.season = $Season
        $outobject.episodeType = $EpisodeType
        $outobject.imgURL = $ImgUrl
        $outobject.subtitle = $Subtitle
        $outobject.summary = $Summary
        $outobject.description = $Description
        $outobject.descriptionHTML = $DescriptionHTML
        $outobject.chapters = $Chapters

        return $outobject
    }
    End {}
}

Export-ModuleMember New-PodcastEpisode