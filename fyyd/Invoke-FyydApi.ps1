function Invoke-FyydApi {
    [CmdletBinding()]
    param (
        [string[]] $parameterList,
        [string] $endpoint,
        [ValidateSet("Default", "Get", "Head", "Post", "Put", "Delete", "Trace", "Options", "Merge", "Patch")]
        [string] $method = "Get"
    )
    Begin {
        [string] $apiurl = "https://api.fyyd.de/0.2"
    }
    Process {
        [string] $parameterString = $parameterList -Join "&"

        [string] $uri = $apiurl + $endpoint + "?" + $parameterString
        $uri = [uri]::EscapeUriString($uri) 

        Write-Debug $uri 
        $jsondata = Invoke-RestMethod -Method $method -Uri $uri

        return $jsondata
    }
    End {}
}

Export-ModuleMember Invoke-FyydApi