<#
.Synopsis
    Returns information about the curations this episode is in.
.DESCRIPTION
    Returns information about the curations this episode is in.
.EXAMPLE
    Get-FyydEpisodeCurations -id 1209129
#>
function Get-FyydEpisodeCurations {
	[CmdletBinding()]
	param (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true, Position=0)]
        [Alias("id")]
        [int] $episode_id,

        [Parameter(Mandatory=$false, Position=1)]
        [int] $page = 0,

        [Parameter(Mandatory=$false, Position=2)]
        [int] $count = 50
        )
    
    Begin {}
    Process {
        [string[]] $parameter = @()     # init parameter array

        $parameter += "episode_id=$episode_id" 
        $parameter += "page=$page"
        $parameter += "count=$count"

        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/episode/curations" -method "Get"

        return $jsondata.data
    }
    End{}
}

Export-ModuleMember Get-FyydEpisodeCurations