<#
.Synopsis
    Returns information about a single curation.
.DESCRIPTION
    Returns information about a single curation, given the curation's id. If you're authenticated and you request your own curation, non-public curations will be accessable too.
.EXAMPLE
    Get-FyydCuration -id 1209129
#>
function Get-FyydCuration {
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

        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/curation" -method "Get"

        return $jsondata.data
    }
    End{}
}

Export-ModuleMember Get-FyydCuration