function Invoke-AuphonicApi {
    [CmdletBinding()]
    param (
        [PSCredential] $Credential,
        [string] $Endpoint,
        [string[]] $ParameterList,
        [string] $InFile,
        [ValidateSet("Default", "Get", "Post", "Upload")]
        [string] $Method = "Get"
        )
        Begin {
            [string] $apiurl = "https://auphonic.com/api/"
            if ([string]::IsNullOrEmpty($credential.UserName)) {
                $credential = Get-Credential
            }
            [string]$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $credential.username,$credential.GetNetworkCredential().password)))
        }
        Process {
            [psobject] $jsondata =$null
            $headers = @{}
            $headers += @{Authorization=("Basic {0}" -f $base64AuthInfo)}
            
            
            [string] $uri = $apiurl + $endpoint        
            [string] $parameterString = $parameterList -Join "&"
            
            switch ($method) {
                "Post" {
                    Write-Debug "URL: $uri"
                    $jsondata = Invoke-RestMethod -Method $method -Uri $uri -Headers $headers -ContentType 'application/json' -Body $parameterString
                    break
                }

                "Upload" {
                    Write-Debug "URL: $uri"
                    $jsondata = Invoke-RestMethod -Method Post -Uri $uri -Headers $headers -InFile $InFile -ContentType 'multipart/form-data'
                    break
                }

                Default {
                    $uri += "?" + $parameterString
                    $uri = [uri]::EscapeUriString($uri)
                    Write-Debug "URL: $uri"
                    $jsondata = Invoke-RestMethod  -Method $method -Uri $uri -Headers $headers
                }
            }
        return $jsondata.data
    }
    End {}
}

function Get-AuphonicPresets {
    [CmdletBinding()]
    param (
        [PSCredential] $credential,
        [Switch] $full
    )
    Begin {}
    Process {
        $endpoint = "presets.json"       
        if (-not $full) {$parameterString = "minimal_data=1"}
        Invoke-AuphonicApi -credential $credential -method Get -endpoint $endpoint -parameterList $parameterString
    }
    End{}
}


function Get-AuphonicProductions {
    [CmdletBinding()]
    param (
        [PSCredential] $credential,
        [Switch] $full
    )
    Begin {}
    Process {
        $endpoint = "productions.json"       
        if (-not $full) {$parameterString = "minimal_data=1"}
        Invoke-AuphonicApi -credential $credential -method Get -endpoint $endpoint -parameterList $parameterString
    }
    End{}
}

function New-AuphonicProduction {
    [CmdletBinding()]
    param (
        [PSCredential] $credential,
        [string] $preset,
        [string] $title
    )
    Begin {}
    Process {
        $json=@{preset=$preset;
         metadata= @{title=$title}
        }
        $jsonstring = ConvertTo-Json -InputObject $json
        $endpoint = "productions.json"
        Invoke-AuphonicApi -credential $credential -method Post -endpoint $endpoint -parameterList $jsonstring
    }
    End{}
}

function Invoke-AuphonicUpload {
    [CmdletBinding()]
    param (
        [string] $ProductionUUID,
        [string] $InFile,
        [PSCredential] $credential
    )
    Begin {}
    Process {
        $endpoint = "production/"+ $ProductionUUID + "/upload.json"
        Invoke-AuphonicApi -credential $credential -method Upload -endpoint $endpoint -InFile $InFile
    }
    End{}
}




Export-ModuleMember Invoke-AuphonicApi, Get-AuphonicPresets, Get-AuphonicProductions, New-AuphonicProduction, Invoke-AuphonicUpload, Invoke-AuphonicUpload