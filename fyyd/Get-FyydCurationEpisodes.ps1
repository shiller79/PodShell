<#
.Synopsis
    Returns episodes of a curation.
.DESCRIPTION
    Returns episodes of a curation, given the curation's id. not paged at the moment. If you're authenticated and you request your own curation, non-public curations will be accessable too.
.EXAMPLE
    Get-FyydCurationEpisodes -id 1209129
#>
function Get-FyydCurationEpisodes {
	[CmdletBinding()]
	param (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true, Position=0)]
        [Alias("id")]
        [int] $curation_id
    )
    
    Begin {}
    Process {
        [string[]] $parameter = @()     # init parameter array

        $parameter += "curation_id=$curation_id" 

        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/curation/episodes" -method "Get"

        return $jsondata.data.episodes
    }
    End{}
}

Export-ModuleMember Get-FyydCurationEpisodes