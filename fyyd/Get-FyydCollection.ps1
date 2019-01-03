<#
.Synopsis
    Returns information about a single collection, given the collection's id.
.DESCRIPTION
    Returns information about a single collection, given the collection's id.
.EXAMPLE
    Get-FyydPodcast -slug sendegarten-de
#>
function Get-FyydCollection {
	param (
        [Parameter(Mandatory=$true, Position=0)]
        [Alias("id")]
        [int] $collection_id
    )
    
    Begin {}
    Process {
        [string[]] $parameter = @()     # init parameter array
        
        $parameter += "collection_id=$collection_id"

        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/collection/podcasts" -method "Get"

        return $jsondata.data
    }
    End{}
}

Export-ModuleMember Get-FyydCollection