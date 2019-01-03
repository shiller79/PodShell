<#
.Synopsis
    Returns this account's curations. Includes non-public curations as well.
.DESCRIPTION
    Returns this account's curations. Includes non-public curations as well.
.EXAMPLE
    Get-FyydAccountCurations
#>
function Get-FyydAccountCurations {
    [CmdletBinding()]
    param ()
    
    Begin {}
    Process{        
        $jsondata = Invoke-FyydApi -endpoint "/account/curations" -method "Get"

        return $jsondata.data
    }
    End {}
}

Export-ModuleMember Get-FyydAccountCurations