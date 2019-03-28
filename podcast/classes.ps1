class pwpShow {
    [string]$title
    [string]$subtitle
    [string]$summary
    [string]$poster
    [string]$link
}

class pwpAudio {
    [string]$url
    [string]$size
    [string]$title
    [string]$mimeType
}

class pwpChapter {
    [string]$start
    [string]$title
    [string]$href
    [string]$img
}

class pwp {
    [pwpShow]$show = [pwpShow]::new()
    [string]$title
    [string]$subtitle
    [string]$summary
    [string]$publicationDate
    [string]$poster
    [string]$duration
    [string]$link
    [pwpAudio[]]$audio = @() 
    [pwpChapter[]]$chapters = @()
}


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
        [parameter(Mandatory, ValueFromPipeline)]
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

function Get-RedirectUrl {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]
        $Uri,
        [int]
        $MaximumRedirection = 10
    )
    
    begin {}
    
    process {
        do {
            $response = Invoke-WebRequest -Method Head -MaximumRedirection 0 -ErrorAction SilentlyContinue -uri $Uri
            if (($response.StatusCode -ge 300) -and ($response.StatusCode -le 399 )) {
                $Uri = $response.Headers.Location
                Write-Verbose $Uri
                Write-Verbose $response.StatusCode
                $MaximumRedirection--
            }
            else {
                $MaximumRedirection = 0
            }
        } while ($MaximumRedirection -gt 0 )#loop while Status Code is 3xx Redirect
        Write-Verbose $Uri
        return $Uri
    }

    end {}
}


Export-ModuleMember Find-LinksInString, Get-RedirectUrl