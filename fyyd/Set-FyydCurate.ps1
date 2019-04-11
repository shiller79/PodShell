<#
.Synopsis
    Modifies a curation.
.DESCRIPTION
    Adds OR removes the episode identified by episode_id into the curation identified by curation_id. 
    The curation must be owned by the user identified by the accesstoken. The state of the episode inside this curation toggles with each call, 
    the state is returned inside response's data section.
.EXAMPLE
    Set-FyydCurate -curation_id 3135 -episode_id 3269363
#>
function Set-FyydCurate {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $false, Position = 0)]
        [int] $curation_id,
        
        [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory = $false, Position = 1)]
        [Alias("FyydEpisodeId")]
        [int] $episode_id,

        [Parameter(Mandatory = $false, Position = 2)]
        [string] $why,

        [Parameter(Mandatory = $false, Position = 3)]
        [int] $force_state
    )
        
    Begin { }
    Process {
        [string[]] $parameter = @()     # init parameter array
            
        $parameter += "curation_id=$curation_id"
        $parameter += "episode_id=$episode_id"
        switch ($PSBoundParameters.Keys) {
            'why' { $parameter += "why=$why" }
            'force_state' { $parameter += "force_state=$force_state" }
        }
    
        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/curate" -method "Post" 
    
        return $jsondata.data
    }
    End { }
}
Export-ModuleMember Set-FyydCurate