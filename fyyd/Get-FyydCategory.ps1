<#
.Synopsis
    Retrieves the podcasts inside the specified category.
.DESCRIPTION
    Retrieves the podcasts inside the specified category. The categories system referres to Apple's iTunes Categories. Categories not in Apple's specification are ignored on import.
.EXAMPLE
    Get-FyydCategory -category_id 62
#>
function Get-FyydCategory {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory=$true)]
        [Alias("id")]
        [string] $category_id
    )

    Begin {}
    Process {
        [string[]] $parameter = @()     # init parameter array
        $parameter += "category_id=$category_id"
        
        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/category" -method "Get"

        return $jsondata
    }
    End{}
}

Export-ModuleMember Get-FyydCategory