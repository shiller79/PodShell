
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
  [int]$FyydEpisodeId
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
  [int]$FyydPodcastId
  [uri]$FyydUrl
  [int]$ItunesId
  [int]$PanoptikumId
  [string]$wikidata
  [System.Object]$rawdata
}


$uri = "https://query.wikidata.org/sparql?query="
$method = "GET"
        

$query = 'SELECT ?item ?itemLabel ?feedurl ?Panoptikum_ID ?fyyd_podcast_ID ?iTunesID WHERE {
  ?item (wdt:P31/(wdt:P279*)) wd:Q24634210;
    wdt:P1019 ?feedurl.
  SERVICE wikibase:label { bd:serviceParam wikibase:language "en". }
  OPTIONAL { ?item wdt:P4818 ?Panoptikum_ID. }
  OPTIONAL { ?item wdt:P7583 ?fyyd_podcast_ID. }
  OPTIONAL { ?item wdt:P5842 ?iTunesID. }
}'


$query = $query -replace "`t|`n|`r", ""  #remove newline an CR
$query = [uri]::EscapeDataString($query)
$uri += $query
Write-Debug "URL: $uri"
#$uri

$jsondata = Invoke-RestMethod -Method $method -Uri $uri -Headers $headers

#return $jsondata
$results = $jsondata.sparql.results.result
[Podcast[]]$outobject = @()

foreach ($result in $results) {
  [Podcast]$podcastobject = [Podcast]::new()

  foreach ($binding in $result.binding) {
    switch ($binding.name) {
      "itemLabel" { $podcastobject.Title = $binding.literal.'#text' }
      "Panoptikum_ID" { $podcastobject.PanoptikumId = $binding.literal }
      "iTunesID" { $podcastobject.itunesId = $binding.literal }
      "feedurl" { $podcastobject.XmlUrl = $binding.uri }
      Default {
        #  Write-Host "- $($result.name) $($result.uri)"
        #$result
      }
    }
  }
  # $podcastobject
  $outobject += $podcastobject
}
#return $jsondata.sparql.results
return $outobject
