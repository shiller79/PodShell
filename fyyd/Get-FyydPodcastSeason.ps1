<#
.Synopsis
    Gets episodes of the podcast with id or slug
.DESCRIPTION
    Gets episodes from a season of a podcast with id fyyd-id.
    Additionally you can address the resultset with page and {count.
.Parameter id
    the podcast's fyyd-id
.Parameter sulg
    the podcast's slug
.Parameter season
    the seasons number
.Parameter episode
    an episodes number to retrieve
.Parameter page
    the page you want to address, default: 0  
.Parameter count
    the page's size, default: 50

.EXAMPLE
    Get-FyydPodcastSeason -id 703 -season 1
#>
function Get-FyydPodcastSeason {
    [OutputType('Episode')]
    [CmdletBinding(DefaultParametersetName = "id")]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "id", Position = 0)]
        [Alias("id")]
        [int] $podcast_id,

        [Parameter(Mandatory = $true, ParameterSetName = "slug", Position = 0)]
        [string] $slug,

        [Alias("num_season", "season_number")]
        [Parameter(Mandatory = $true, Position = 1)]
        [int] $season,

        [Parameter(Mandatory = $false, Position = 2)]
        [int] $episode,

        [Parameter(Mandatory = $false, Position = 3)]
        [int] $page = 0,

        [Parameter(Mandatory = $false, Position = 4)]
        [int] $count = 50
    )

    Begin {}
    Process {
        [string[]] $parameter = @()     # init parameter array
        switch ($PsCmdlet.ParameterSetName) {
            "id" { $parameter += "podcast_id=$id" ; break }
            "slug" { $parameter += "podcast_slug=$slug" ; break }
        } 

        $parameter += "season_number=$season"
        $parameter += "episode_number=$episode"
        $parameter += "page=$page"
        $parameter += "count=$count"

        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/podcast/season" -method "Get"

        $outobject = Convert-FyydJson2EpisodeObject $jsondata.data.episodes
        return $outobject
    }
    End {}
}

Export-ModuleMember Get-FyydPodcastSeason