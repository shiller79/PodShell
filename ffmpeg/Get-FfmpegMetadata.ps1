class Chapter {
    [string]$Start
    [string]$Title
    [string]$href
    [string]$img
}

class Enclosure {
    [string]$Url
    [string]$Length
    [string]$type
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
    [int]$FyydEpisodeId
    [System.Object]$rawdata
}

$inputfile = "..\..\temp\test.ini"

$inifile = Get-Content $inputfile -Encoding utf8 


[Chapter]$ChapterObject
$chaptersection = $false
$multilinename = $false
[Episode]$Episode = [Episode]::new()

switch -regex ($inifile) {
    "^\[CHAPTER\]" {
        # new Chapter
        [Chapter]$ChapterObject = [Chapter]::new()
        $Episode.Chapters += $ChapterObject
        $chaptersection = $true
    }
    "^(;.*)$" {
        # Ignore Comments
    }
    "(.+?)\s*=(.*)" {
        # Key
        $name, $value = $matches[1..2]
        if ($chaptersection) {
            switch ($name) {
                "title" { $ChapterObject.Title = $value }
                "START" { $ChapterObject.Start = $value / 1000; }
                "END" { $Episode.duration = New-TimeSpan -Seconds ($value / 1000) }
            }
            Write-Debug "Chaper: $name  $value"
        }
        else {
            switch ($name) {
                "title" { $Episode.Title = $value }
                "comment" { }
            }
            Write-Host "$name  $value"
        }
    }
}


return $Episode
