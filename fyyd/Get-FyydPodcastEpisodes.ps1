<#
.Synopsis
    Gets episodes of the podcast with id or slug
.DESCRIPTION
    Gets episodes of the podcast with id or slug
.Parameter id
    the podcast's fyyd-id
.Parameter sulg
    the podcast's slug
.Parameter page
    the page you want to address, default: 0  
.Parameter count
    the page's size, default: 50
.EXAMPLE
    Get-FyydPodcastEpisodes -id 42
#>
function Get-FyydPodcastEpisodes {
	[CmdletBinding(DefaultParametersetName="id")]
	param (
		[Parameter(Mandatory=$true, ParameterSetName="id", Position=0)]
        [Alias("id")]
        [int] $podcast_id,

		[Parameter(Mandatory=$true, ParameterSetName="slug", Position=0)]
        [string] $slug,

        [Parameter(Mandatory=$false, Position=1)]
        [int] $page = 0,

        [Parameter(Mandatory=$false, Position=2)]
        [int] $count = 50
    )

    Begin {}
    Process {
        [string[]] $parameter = @()     # init parameter array
        
        switch ($PsCmdlet.ParameterSetName)
        {
            "id"    { $parameter += "podcast_id=$podcast_id" ; break }
            "slug"  { $parameter += "podcast_slug=$slug" ; break }
        } 

        $parameter += "page=$page"
        $parameter += "count=$count"

        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/podcast/episodes" -method "Get"

        return $jsondata.data.episodes
    }
    End {}
}

Export-ModuleMember Get-FyydPodcastEpisodes