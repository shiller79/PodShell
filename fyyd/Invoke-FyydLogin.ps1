<#
.Synopsis
    fyyd login
.DESCRIPTION
    Performs the login to fyyd.de
.EXAMPLE
    Invoke-FyydLogin
#>
function Invoke-FyydLogin {
    [CmdletBinding()]
    param ()
    
    Begin {}
    Process{
        $ClientID = "wrkrmx34e8l1bxetbdhum2otrlhfyDkqjv5v8vf2ndiwrpzaw"
        $AuthorizeUri = "https://fyyd.de/oauth/authorize"
        
        $web = new-object -com "InternetExplorer.Application"
        
        $web.Navigate("$AuthorizeUri\?client_id=$ClientID")
        $web.visible = $true
        
        [bool] $waitforlogin = $true
        while($waitforlogin) {
            Start-Sleep 1
            $url = $web.LocationURL
            Write-Verbose "Url: $url"
            
            if($web.LocationURL -match "token=([^&]*)") {
                $AccessToken = $Matches[1]
                Write-Host "Token: $AccessToken"
                $global:fyydAccessToken = $AccessToken
                $waitforlogin = $false;
            } elseif ($web.LocationURL -match "error=([^&]*)") {
                $LoginError = $Matches[1]
                Write-Error "Error: $LoginError"
                $waitforlogin = $false;
            }
        }
    }
    End {}
}

Export-ModuleMember Invoke-FyydLogin