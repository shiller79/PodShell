<#
.Synopsis
    Retuns the state of the curation of an episode in a curation.
.DESCRIPTION
    Retuns the state of the curation of an episode in a curation.
.EXAMPLE
    Get-FyydCurate -curation_id 3105 -episode_id 3260062
#>
function Get-FyydCurate {
	[CmdletBinding()]
	param (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true, Position=0)]
        [int] $curation_id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true, Position=1)]
        [int] $episode_id
    )
    
    Begin {}
    Process {
        [string[]] $parameter = @()     # init parameter array

        $parameter += "curation_id=$curation_id"
        $parameter += "episode_id=$episode_id"

        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/curate" -method "Get"

        return $jsondata.data
    }
    End{}
}

Export-ModuleMember Get-FyydCurate