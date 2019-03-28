<#
.Synopsis
    Starts the Podlove Webplayer in default browser.
.DESCRIPTION
    Starts the Podlove Webplayer in default browser.
.EXAMPLE
    $podcast = Get-PodcastFeed https://www.nussschale-podcast.de/feed/mp3/
    Export-WebplayerJson -Episode $podcast.Episodes[0] -Podcast $podcast | Start-PodloveWebPlayer
#>
function Start-PodloveWebplayer {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, Mandatory = $true, Position = 0)]
        [string]$config
    )
    $templatepath = Join-Path $PSScriptRoot "webpalyer.html"
    [string]$template = Get-Content $templatepath
    $config = [System.Web.HttpUtility]::HtmlEncode($config) 

    $temppath = Join-Path $env:TEMP "playertemp.html"
    $template.Replace("{*config*}", $config) | Set-Content -Path $temppath

    Invoke-Item $temppath
}

Export-ModuleMember Start-PodloveWebplayer