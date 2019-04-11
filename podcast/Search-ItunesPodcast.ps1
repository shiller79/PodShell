<#
.Synopsis
    Search for Podcasts in itunes
.DESCRIPTION
    Search for Podcasts in itunes
.EXAMPLE
    Search-ItunesPodcast
#>
function Search-ItuesPodcast {
    [OutputType('Podcast')]
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true, Position = 0)]
        [string] $term
    )
    
    Begin {}
    Process {
         
        $itunes = Invoke-RestMethod -Method "GET" -Uri "https://itunes.apple.com/search?country=de&media=podcast&term=$term"
        Write-Verbose $itunes

        [Podcast[]] $outobject = @()
        foreach ($item in $itunes.results) {
            
            [Podcast]$ituesobject = [Podcast]::new()
            
            $ituesobject.Title = $item.collectionName
            $ituesobject.ImgUrl = $itunes.artworkUrl600
            $ituesobject.XmlUrl = $item.feedUrl
            if ($item.collectionExplicitness -eq "explicit") {$ituesobject.explicit = $true}
            try { $ituesobject.pubdate = [DateTime]::Parse($item.releaseDate) }  catch {Write-Verbose "Error parsing pubdate"}
            #todo: trackCount?, Cathegory
            $ituesobject.rawdata = $item

            $outobject += $ituesobject
        }
        return $outobject
    }
    End {}
}

Export-ModuleMember Search-ItuesPodcast