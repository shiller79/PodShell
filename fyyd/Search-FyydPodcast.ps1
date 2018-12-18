<#
.Synopsis
    This request tries to find a podcast inside fyyd's database, matching any or some of a set of given criteria.
.DESCRIPTION
    This request tries to find a podcast inside fyyd's database, matching any or some of a set of given criteria.
.Parameter title
    the podcast's title. Search might use parts of the string to find the podcast.
.Parameter url
    the podcast's url as stated inside the podcast's feed.
.Parameter term
    a search term to find inside the podcast.

.EXAMPLE
    Search-FyydPodcast -title "Freak-Schow"
#>
function Search-FyydPodcast {
    [CmdletBinding()]
	param (
        [Parameter(Mandatory=$false)]
        [Alias("podcast_title")]
        [string] $title,
    
        [Parameter(Mandatory=$false)]
        [string] $url,

        [Parameter(Mandatory=$false)]
        [string] $term,

        [Parameter(Mandatory=$false)]
        [int] $count = 10
    )
    
    [string[]] $parameter = @()     # init parameter array
    if ($title) { $parameter += "title=$title" }
    if ($term) { $parameter += "term=$term" }
    if ($url) { $parameter += "url=$url" }
    if ($count) { $parameter += "count=$count" }
    
    $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/search/podcast" -method "Get"

    return $jsondata.data
}

Export-ModuleMember Search-FyydPodcast