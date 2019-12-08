function Export-m3u {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $true, Position = 0)]
        [Object[]]$Episodes,

        [Parameter(Mandatory = $false, Position = 1)]
        [string] $FilePath,

        [Parameter(Mandatory = $false)]
        [switch]
        $simpel
    )
        
    Begin {
        [string[]]$output = @()
        if (-not $simpel) { $output += "#EXTM3U" }
    }
    Process {

        if (-not $simpel) { $output += "#EXTINF:" + $Episodes.Duration.TotalSeconds + "," + $Episodes.Title }
        $output += $Episodes.Enclosure.Url

    }
    End {
        if ($FilePath) {
            Out-File -FilePath $FilePath -InputObject $output 
        }
        else {
            return $output
        }
    }
}

Export-ModuleMember Export-m3u