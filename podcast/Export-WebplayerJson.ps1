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



function Export-WebplayerJson {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $true, Position = 0)]
        [Episode] $Episode,
        
        [Parameter(Mandatory = $true, Position = 1)]
        [Podcast]$Podcast,

        [Parameter(Mandatory = $true, Position = 2)]
        [string] $Path
    )
        
    Begin {}
    Process {
        [pwp]$OutObject = [pwp]::new()
        
        $OutObject.title = $Episode.Title
        $OutObject.subtitle = $Episode.SubTitle
        $OutObject.summary = $Episode.Summary
        $OutObject.poster = $Episode.imgUrl
        $OutObject.publicationDate = $Episode.pubdate
        $OutObject.link = $Episode.htmlUrl
        $OutObject.duration = $Episode.duration
        
        $OutObject.show.title = $Podcast.Title
        $OutObject.show.subtitle = $Podcast.SubTitle
        $OutObject.show.summary = $Podcast.summary
        $OutObject.show.link = $Podcast.htmlUrl
        $OutObject.show.poster = $Podcast.imgUrl
        
        [pwpAudio]$audio = [pwpAudio]::new()
        $audio.url = $Episode.Enclosure.Url
        $audio.mimeType = $Episode.Enclosure.Type
        $audio.size = $Episode.Enclosure.Length
        $OutObject.audio += $audio
        
        foreach ($chapter in $Episode.Chapters) {
            [pwpChapter]$chapterobject = [pwpChapter]::new()
            $chapterobject.start = $chapter.start
            $chapterobject.title = $chapter.title
            $chapterobject.href = $chapter.href
            $chapterobject.img = $chapter.img 

            $OutObject.chapters += $chapterobject
        }

        $OutObject | ConvertTo-Json -depth 100 | Out-File $Path
    }
    End {}
}
Export-ModuleMember Export-WebplayerJson