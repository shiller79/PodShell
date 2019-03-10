class Enclosure {
    [string]$Url
    [string]$Length
    [string]$type
}


class Chapter {
    [string]$Start
    [string]$Title
    [string]$href
    [string]$img
}


class Episode {
    [string]$Title
    [string]$Guid
    [string]$Url
    [Enclosure]$Enclosure = [Enclosure]::new()
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
    [Chapter[]]$Chapters = @()
    [System.Object]$rawdata
}

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
    [Episode[]]$Episodes = @()
    [bool]$Explicit
    [bool]$Block
    [System.Object]$rawdata
}

function Find-LinksInString {
    [CmdletBinding()]
    param (
        $String 
    )
    
    begin {
        $url_regex = [Regex]::new("(http|ftp|https)://([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?")
    }
    
    process {
        $links = ($url_regex.Matches($String))
        if (![string]::IsNullOrEmpty($links.Value)) { return $links.Value }
    }
    
    end {
    }
}

Export-ModuleMember Find-LinksInString