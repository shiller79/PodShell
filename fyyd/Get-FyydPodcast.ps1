<#
.Synopsis
    Retrieves the podcasts inside the specified category.
.DESCRIPTION
    Gets information about the podcast with id or slug
.EXAMPLE
    Get-FyydPodcast -slug sendegarten-de
#>
function Get-FyydPodcast {
    [OutputType('Podcast')]
    [CmdletBinding(DefaultParametersetName = "id")]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "id", Position = 0)]
        [Alias("id")]
        [int] $podcast_id,

        [Parameter(Mandatory = $true, ParameterSetName = "slug", Position = 0)]
        [string] $slug
    )
    
    Begin {}
    Process {
        [string[]] $parameter = @()     # init parameter array

        switch ($PsCmdlet.ParameterSetName) {
            "id" { $parameter += "podcast_id=$podcast_id" ; break }
            "slug" { $parameter += "podcast_slug=$slug" ; break }
        } 

        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/podcast" -method "Get"

        $outobject = Convert-FyydJson2PodcastObject $jsondata.data
        return $outobject
    }
    End {}
}

Export-ModuleMember Get-FyydPodcast