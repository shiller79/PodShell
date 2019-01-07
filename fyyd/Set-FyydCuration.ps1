<#
.Synopsis
    Modifies a curation.
.DESCRIPTION
    Modifies a curation.
.EXAMPLE
    Set-FyydCuration -id 3135 -title "Test Curation" -description "This is a curation" -slug "test" -public 1
#>
function Set-FyydCuration {
	[CmdletBinding()]
	param (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$false, Position=0)]
        [Alias("id")]
        [int] $curation_id,
        
        [Parameter(Mandatory=$false, Position=1)]
        [string] $title,
    
        [Parameter(Mandatory=$false, Position=2)]
        [string] $description,
    
        [Parameter(Mandatory=$false, Position=3)]
        [string] $slug,
    
        [Parameter(Mandatory=$false, Position=4)]
        [int] $public
        )
        
        Begin {}
        Process {
            [string[]] $parameter = @()     # init parameter array
            
            $parameter += "curation_id=$curation_id"
            switch ($PSBoundParameters.Keys) {
                'title'         { $parameter += "title=$title" }
                'description'   { $parameter += "description=$description" }
                'slug'          { $parameter += "slug=$slug" }
                'public'        { $parameter += "public=$public" }
           }
    
            $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/curation" -method "Post" 
    
            return $jsondata.data
        }
        End{}
    }
Export-ModuleMember Set-FyydCuration