<#
.Synopsis
    Returns this account's collections.
.DESCRIPTION
    Returns this account's collections.
.EXAMPLE
    Get-FyydAccountCollections
#>
function Get-FyydAccountCollections {
    [CmdletBinding()]
    param ()
    
    Begin {}
    Process{        
        $jsondata = Invoke-FyydApi -endpoint "/account/collections" -method "Get"

        return $jsondata.data
    }
    End {}
}

Export-ModuleMember Get-FyydAccountCollections