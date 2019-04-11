function Export-m3u {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $true, Position = 0)]
        [Object[]]$Episodes,

        [Parameter(Mandatory = $false, Position = 1)]
        [string] $Path
    )
        
    Begin {
        [string[]]$output = @()
    }
    Process {

        $output += $Episodes.Enclosure.Url

    }
    End {

        return $output
        
    }
}

Export-ModuleMember Export-m3u