<#
.Synopsis
    Returns information about a single episode.
.DESCRIPTION
    Gets information about the episode with id
.EXAMPLE
    Get-FyydEpisode -id 1209129
#>
function Get-FyydEpisode {
    [OutputType('Episode')]
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $true, Position = 0)]
        [Alias("id", "FyydEpisodeId")]
        [int] $episode_id
    )
    
    Begin {}
    Process {
        [string[]] $parameter = @()     # init parameter array

        $parameter += "episode_id=$episode_id" 

        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/episode" -method "Get"

        $outobject = Convert-FyydJson2EpisodeObject $jsondata.data
        return $outobject
    }
    End {}
}

Export-ModuleMember Get-FyydEpisode