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
        Write-Debug "URL: $uri"

        $headers = @{}
        if (-not [string]::IsNullOrEmpty($fyydAccessToken)) {
            $headers.Add("Authorization", "Bearer $fyydAccessToken")
            Write-Debug "Add Header `"Authorization`" `"Bearer $fyydAccessToken`""
        }
        
        $jsondata = Invoke-RestMethod -Method $method -Uri $uri -Headers $headers
    
        return $jsondata
    }
    End {}
}

Export-ModuleMember Invoke-FyydApi