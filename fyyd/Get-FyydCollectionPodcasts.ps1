<#
.Synopsis
    Returns the podcasts in a collection based on the collection's id.
.DESCRIPTION
    Returns the podcasts in a collection based on the collection's id.
.EXAMPLE
    Get-FyydPodcast -slug sendegarten-de
#>
function Get-FyydCollectionPodcasts {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias("id")]
        [int] $collection_id
    )
    
    Begin {}
    Process {
        [string[]] $parameter = @()     # init parameter array
        
        $parameter += "collection_id=$collection_id"

        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/collection/podcasts" -method "Get"

        $outobject = Convert-FyydJson2PodcastObject $jsondata.data.podcasts
        return $outobject
    }
    End {}
}

Export-ModuleMember Get-FyydCollectionPodcasts