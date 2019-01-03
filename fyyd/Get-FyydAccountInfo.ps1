<#
.Synopsis
    Returns general information about the account
.DESCRIPTION
    Returns general information about the account
.EXAMPLE
    Get-FyydAccountInfo
#>
function Get-FyydAccountInfo {
    [CmdletBinding()]
    param ()
    
    Begin {}
    Process{        
        $jsondata = Invoke-FyydApi -endpoint "/account/info" -method "Get"

        return $jsondata.data
    }
    End {}
}

Export-ModuleMember Get-FyydAccountInfo