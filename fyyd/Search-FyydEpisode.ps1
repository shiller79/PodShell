<#
.Synopsis
    This request tries to find an episode inside fyyd's database, matching any or some of a set of given criteria.
.DESCRIPTION
    This request tries to find an episode inside fyyd's database, matching any or some of a set of given criteria.
.Parameter title
    the episode's title. Search might use parts of the string to find the episode
.Parameter guid
    the episode's GUID as stated inside the podcasts feed.
.Parameter podcast_id
    the podcast's id in fyyd's database. 
.Parameter podcast_title
    the podcast's title. Search might use parts of the string to find the podcast.
.Parameter pubdate
    the pubDate as stated inside the podcasts feed.
.Parameter duration
    the duration of the episode in seconds.
.Parameter url
    the episode's url as stated inside the podcast's feed.
.Parameter term
    a search term to find inside the episodes.

.EXAMPLE
    Search-FyydEpisodes -title "Zeit"
#>
function Search-FyydEpisode {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName, Position = 0)]
        [string] $title,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName)]
        [string] $guid,

        [Alias("id")]
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName)]
        [int] $podcast_id,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName)]
        [string] $pubdate,
        
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName)]
        [int] $duration,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName)]
        [string] $url,

        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName)]
        [string] $podcast_title,
    
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName)]
        [string] $term,

        [Parameter(Mandatory = $false)]
        [int] $count = 10
    )
    begin {}
    process {
        [string[]] $parameter = @()     # init parameter array
        if ($title) { $parameter += "title=$title" }
        if ($guid) { $parameter += "guid=$guid" }
        if ($podcast_id) { $parameter += "podcast_id=$podcast_id" }
        if ($pubdate) { $parameter += "pubdate=$pubdate" }
        if ($duration) { $parameter += "duration=$duration" }
        if ($url) { $parameter += "url=$url" }
        if ($podcast_title) { $parameter += "podcast_title=$podcast_title" }
        if ($podcast_id) { $parameter += "podcast_id=$podcast_id" }
        if ($term) { $parameter += "term=$term" }
        if ($count) { $paremeter += "count=$count" }
        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/search/episode" -method "Get" -ErrorAction Continue

        return $jsondata.data
    }
    end {}
}

Export-ModuleMember Search-FyydEpisode