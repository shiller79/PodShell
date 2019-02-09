class Podcast {
    [string]$Title
    [string]$Subtitle
    [string]$Summary
    [string]$ImgUrl
    [string]$XmlUrl
    [string]$HtmlUrl
    [string]$FirstUrl
    [string]$NextUrl
    [string]$PreviousUrl
    [string]$LastUrl
    [string]$Language
    [string]$Generator
    [datetime]$PubDate
    [System.Object]$rawdata
}

class Episode {
    [string]$Title
    [string]$Guid
    [string]$Url
    [string]$Enclosure
    [string]$Duration
    [datetime]$PubDate
    [int]$Episode
    [int]$Season
    [string]$EpisodeType
    [string]$imgURL
    [string]$Subtitle
    [string]$Summary
    [string]$Description
    [string]$DescriptionHTML
    [System.Object]$Chapters
    [System.Object]$rawdata
}

