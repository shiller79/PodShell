function Get-PodShellHttpStatus {
    param (
        [Parameter(ValueFromPipeline = $true)]
        [string] $Url 
    )
    try {
        $status = Invoke-WebRequest -Uri $Url -Method Head -MaximumRedirection 0 -ErrorAction Ignore  
    }
    catch {
        continue    
    }
    return $status
}

function Get-PodshellHttpLocation {
    param (
        [Parameter(ValueFromPipeline = $true)]
        [string] $Url,
        [Parameter()]
        [int] $MaximumRedirection = 5
    )
    [PSObject]$status = @{}

    do {
        $status = Get-PodShellHttpStatus -Url $Url

        if ($status.StatusCode -ge 300 -and $status.StatusCode -le 399) {
            # if Statuecode is 3xx Moved  
            Write-Host "Redirect to :$($status.Headers.Location)"
            $Url = $status.Headers.Location
            $MaximumRedirection--
        }
        else {
            $MaximumRedirection = 0
        }
    } while ($MaximumRedirection -gt 0) 
    
    [string]$filename=""
    if (($status.Headers).PSObject.Properties.Match('Content-Disposition').Count){
        $dummy, $filename = $status.Headers.'Content-Disposition' -split "="
    }

    $returnObject = [PSCustomObject]@{
        Url = $Url
        StatusCode = $status.StatusCode
        Filename = $filename
        Status = $status
    }
    return $returnObject
}

$starturl = "http://tracking.feedpress.it/link/13440/9063168/cre218-diamanten.m4a"
$starturl = "https://logbuch-netzpolitik.de/feed/m4a"

#Get-PodshellHttpStatus $starturl
$zeilurl= (Get-PodshellHttpLocation $starturl)
$dest= [Environment]::GetFolderPath("MyMusic") + "\"  + $zeilurl.Filename
#Start-BitsTransfer -Source $zeilurl.url -Destination $dest