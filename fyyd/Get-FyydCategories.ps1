<#
.Synopsis
    Gets the complete categories tree
.DESCRIPTION
    Gets the complete categories tree.
.EXAMPLE
    Get-FyydCategories
#>
function Get-FyydCategories {
    [CmdletBinding()]
    param ()
    
    Begin {}
    Process {
        $jsondata = Invoke-FyydApi -endpoint "/categories" -method "Get"

        return $jsondata.data
    }
    End {}
}

Export-ModuleMember Get-FyydCategories