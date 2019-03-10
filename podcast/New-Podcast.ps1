<#
.Synopsis
    Creates a Podcast-Object.
.DESCRIPTION
    Creates a Podcast-Object.
.EXAMPLE
    New-Podcast -Titel "New-Podcast"
#>
function New-Podcast {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [string]$Title,
        [Parameter(Position = 1)]
        [string]$Subtitle,
        [Parameter(Position = 2)]
        [string]$Summary,
        [Parameter(Position = 3)]
        [string]$ImgUrl,
        [Parameter(Position = 4)]
        [string]$XmlUrl,
        [Parameter(Position = 5)]
        [string]$HtmlUrl,
        [Parameter(Position = 6)]
        [string]$FirsUrl,
        [Parameter(Position = 7)]
        [string]$NextUrl,
        [Parameter(Position = 8)]
        [string]$PreviousUrl,
        [Parameter(Position = 9)]
        [string]$LastUrl,
        [Parameter(Position = 10)]
        [string]$Language,
        [Parameter(Position = 11)]
        [string]$Generator,
        [Parameter(Position = 12)]
        [datetime]$pubdate = (Get-Date)
    )
        
    Begin {
    }

    Process {
        [Podcast]$outobject = [Podcast]::new()
        $outobject.Title = $Title
        $outobject.Subtitle = $Subtitle
        $outobject.Summary = $Summary
        $outobject.ImgUrl = $ImgUrl
        $outobject.XmlUrl = $XmlUrl
        $outobject.HtmlUrl = $HtmlUrl
        $outobject.FirstUrl = $FirsUrl
        $outobject.NextUrl = $NextUrl
        $outobject.PreviousUrl = $PreviousUrl
        $outobject.LastUrl = $LastUrl
        $outobject.Language = $Language
        $outobject.Generator = $Generator
        $outobject.PubDate = $pubdate
            
        return $outobject
    }
    End { }
}

Export-ModuleMember New-Podcast