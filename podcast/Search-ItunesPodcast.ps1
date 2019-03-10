<#
.Synopsis
    Search for Podcasts in itunes
.DESCRIPTION
    Search for Podcasts in itunes
.EXAMPLE
    Search-ItunesPodcast
#>
function Search-ItuesPodcast {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true, Position = 0)]
        [string] $term
    )
    
    Begin {}
    Process {
         
        $itunes = Invoke-RestMethod -Method "GET" -Uri "https://itunes.apple.com/search?country=de&media=podcast&term=$term"
        Write-Verbose $itunes

        foreach ($item in $itunes.results) {
            
            [Podcast]$outobject = [Podcast]::new()
            
            $outobject.Title = $item.collectionName
            $outobject.ImgUrl = $itunes.artworkUrl600
            $outobject.XmlUrl = $item.feedUrl
            if ($item.collectionExplicitness -eq "explicit") {$outobject.explicit = $true}
            try { $outobject.pubdate = [DateTime]::Parse($item.releaseDate) }  catch {Write-Verbose "Error parsing pubdate"}
            #todo: trackCount?, Cathegory
            $outobject.rawdata = $item

            $outobject
        }
    }
    End {}
}

Export-ModuleMember Search-ItuesPodcast