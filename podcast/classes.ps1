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
    [timespan]$Duration
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

function Convert-FyydJson2EpisodeObject {
    param (
        $fyydEpisode
    )

    #$pubdate = [DateTime]::Parse($fyydEpisode.pubdate)
            
    [Episode]$episodeobject = [Episode]::new()
    $episodeobject.Title = $fyydEpisode.title
    $episodeobject.Guid = $fyydEpisode.guid
    $episodeobject.Url = $fyydEpisode.url

    $episodeobject.Enclosure.Url = $fyydEpisode.enclosure
    #$episodeobject.Enclosure.Length = $item.enclosure.Length
    $episodeobject.Enclosure.Type = $fyydEpisode.content_type

    $episodeobject.duration = New-TimeSpan -Seconds $fyydEpisode.duration
    $episodeobject.pubdate = [DateTime]::Parse($fyydEpisode.pubdate)
    $episodeobject.episode = $fyydEpisode.num_episode
    $episodeobject.season = $fyydEpisode.num_season
    #$episodeobject.episodeType = $item.episodeType
    $episodeobject.imgURL = $fyydEpisode.imgURL
    #$episodeobject.subtitle = $item.subtitle
    #$episodeobject.summary = $item.summary
    #$episodeobject.description = $item.description.InnerText
    $episodeobject.descriptionHTML = $fyydEpisode.description
             
                
    # foreach ($chapter in $item.chapters.chapter) {
                    
    #     [Chapter]$chapterobject = [Chapter]::new()
    #     #$chapter.chapter.start, $chapter.chapter.title, $chapter.chapter.href, $chapter.chapter.img)
    #     $chapterobject.Start = $chapter.start
    #     $chapterobject.Title = $chapter.title
    #     $chapterobject.Href = $chapter.href
    #     $chapterobject.Img = $chapter.img
                    
    #     $episodeobject.Chapters += $chapterobject
    # }

    $episodeobject.rawdata = $fyydEpisode
    return $episodeobject
}


Export-ModuleMember Find-LinksInString, Get-RedirectUrl