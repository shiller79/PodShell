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
            #$outobject.Summary = (Select-Xml -Xml $FeedXml -XPath "/rss/channel/itunes:summary" -Namespace $Namespace).Node.InnerText
            $outobject.ImgUrl = $itunes.artworkUrl600
            $outobject.XmlUrl = $item.feedUrl
            if ($item.collectionExplicitness -eq "explicit") {$outobject.explicit = $true}
            try { $outobject.pubdate = [DateTime]::Parse($item.releaseDate) }  catch {Write-Verbose "Error parsing pubdate"}
            # $outobject.HtmlUrl = (Select-Xml -Xml $FeedXml -XPath "/rss/channel/link" -Namespace $Namespace).Node.InnerText
            # $outobject.FirstUrl = (Select-Xml -Xml $FeedXml -XPath '/rss/channel/atom:link[@rel="first"]' -Namespace $Namespace).Node.href
            # $outobject.NextUrl = (Select-Xml -Xml $FeedXml -XPath '/rss/channel/atom:link[@rel="next"]' -Namespace $Namespace).Node.href
            # $outobject.PreviousUrl = (Select-Xml -Xml $FeedXml -XPath '/rss/channel/atom:link[@rel="next"]' -Namespace $Namespace).Node.href
            # $outobject.LastUrl = (Select-Xml -Xml $FeedXml -XPath '/rss/channel/atom:link[@rel="last"]' -Namespace $Namespace).Node.href
            # $outobject.Language = (Select-Xml -Xml $FeedXml -XPath "/rss/channel/language" -Namespace $Namespace).Node.InnerText
            # $outobject.Generator = (Select-Xml -Xml $FeedXml -XPath "/rss/channel/generator" -Namespace $Namespace).Node.InnerText
            $outobject.rawdata = $item

            $outobject
            #$item
        }
    }
    End {}
}

Export-ModuleMember Search-ItuesPodcast