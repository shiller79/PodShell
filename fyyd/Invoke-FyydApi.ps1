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
        [psobject] $jsondata =$null
        $headers = @{}

        if (-not [string]::IsNullOrEmpty($fyydAccessToken)) {
            $headers.Add("Authorization", "Bearer $fyydAccessToken")
            Write-Debug "Add Header `"Authorization`" `"Bearer $fyydAccessToken`""
        }

        [string] $uri = $apiurl + $endpoint        
        [string] $parameterString = $parameterList -Join "&"

        switch ($method) {
            "Post" {
               Write-Debug "URL: $uri"
               Write-Debug "Body: $parameterString"
               $jsondata = Invoke-RestMethod -Method $method -Uri $uri -Headers $headers -ContentType 'application/x-www-form-urlencoded' -Body $parameterString
               break
            }
            Default {
                $uri += "?" + $parameterString
                $uri = [uri]::EscapeUriString($uri)
                Write-Debug "URL: $uri"
                $jsondata = Invoke-RestMethod -Method $method -Uri $uri -Headers $headers
            }
        }
        
        return $jsondata
    }
    End {}
}

Export-ModuleMember Invoke-FyydApi