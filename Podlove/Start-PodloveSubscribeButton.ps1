<#
.Synopsis
    Opens the Podlove Subscribe Button in default browser.
.DESCRIPTION
    Opens the Podlove Subscribe Button in default browser.
.EXAMPLE
    Start-PodloveSubscribeButton http://famoseworte.de/dtw/m4a  
#>
function Start-PodloveSubscribeButton {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Mandatory = $true, Position = 0)]
        [Alias("XmlUrl")]
        [string]$url
    )
    $subsrcibeurl = "https://subscribe.podlove.org/" + $url

    Start-Process $subsrcibeurl
}

Export-ModuleMember Start-PodloveSubscribeButton