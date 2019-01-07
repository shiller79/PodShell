<#
.Synopsis
    Creates curation.
.DESCRIPTION
    Creates curation.
.EXAMPLE
    New-FyydCuration -title "new Curation" -description "This is a new curation created by PodShell" -slug "test" -public 1
#>
function New-FyydCuration {
	[CmdletBinding()]
	param (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $title,

        [Parameter(Mandatory=$false, Position=1)]
        [string] $description,

        [Parameter(Mandatory=$false, Position=2)]
        [string] $slug,

        [Parameter(Mandatory=$false, Position=3)]
        [int] $public
        )
    
    Begin {}
    Process {
        [string[]] $parameter = @()     # init parameter array

        $parameter += "title=$title"
        switch ($PSBoundParameters.Keys) {
            'description'   { $parameter += "description=$description" }
            'slug'          { $parameter += "slug=$slug" }
            'public'        { $parameter += "public=$public" }
       }

        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/curation" -method "Post" 

        return $jsondata.data
    }
    End{}
}

Export-ModuleMember New-FyydCuration