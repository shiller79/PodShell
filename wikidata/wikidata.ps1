function Invoke-WikidataApi {
  [CmdletBinding()]
  param (
    [string] $query
  )
  Begin {
    [string] $apiurl = "https://query.wikidata.org/sparql?query="
    [string] $method = "Get"
  }

  Process {
    [psobject] $jsondata = $null
    $headers = @{ }

    if (-not [string]::IsNullOrEmpty($fyydAccessToken)) {
      $headers.Add("Authorization", "Bearer $fyydAccessToken")
      Write-Debug "Add Header `"Authorization`" `"Bearer $fyydAccessToken`""
    }

    #  $query = $query -replace "`t|`n|`r", ""  #remove newline an CR
    $query = [uri]::EscapeDataString($query)
    $uri = $apiurl + $query
    Write-Debug "URL: $uri"      

    $jsondata = Invoke-RestMethod -Method $method -Uri $uri 
        
    return $jsondata
  }

  End { }
}


function Get-WikidataPodcasts {
  [CmdletBinding()]
  param (
    [string] $query
  )
  Begin { }
  
  Process {
    $query = 'SELECT ?item ?itemLabel ?FeedUrl ?PanoptikumId ?fyydPodcastId ?iTunesId ?HtmlUrl ?Language  WHERE {
  ?item (wdt:P31/(wdt:P279*)) wd:Q24634210; #all Podcasts

  SERVICE wikibase:label { bd:serviceParam wikibase:language "en". }
  OPTIONAL { ?item wdt:P4818 ?PanoptikumId. }
  OPTIONAL { ?item wdt:P7583 ?FyydPodcastId. }
  OPTIONAL { ?item wdt:P5842 ?iTunesId. }
  OPTIONAL { ?item wdt:P856 ?HtmlUrl. }
  OPTIONAL { ?item wdt:P1019 ?FeedlUrl. }
  OPTIONAL { ?item wdt:P407 [ wdt:P305 ?Language ]. }
}'

    $jsondata = Invoke-WikidataApi -query $query

    $results = $jsondata.sparql.results.result
    [Podcast[]]$outobject = @()

    foreach ($result in $results) {
      [Podcast]$podcastobject = [Podcast]::new()
  
      foreach ($binding in $result.binding) {
        switch ($binding.name) {
          "itemLabel" { $podcastobject.Title = $binding.literal.'#text' }
          "PanoptikumId" { $podcastobject.PanoptikumId = $binding.literal }
          "iTunesId" { $podcastobject.iTunesId = $binding.literal }
          "FeedUrl" { $podcastobject.XmlUrl = $binding.uri }
          "HtmlUrl" { $podcastobject.HtmlUrl = $binding.uri }
          "Language" { $podcastobject.Language = $binding.literal }
        }
      }
      $outobject += $podcastobject
    }
    return $outobject
  }
  End { }
}

Export-ModuleMember Invoke-WikidataApi, Get-WikidataPodcasts