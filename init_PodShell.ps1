Remove-Module Podcast -ErrorAction:SilentlyContinue
Remove-Module fyyd -ErrorAction:SilentlyContinue
#Import-Module .\podcast\podcast.psd1
#Import-Module .\fyyd\fyyd.psd1

$module = Join-Path $PSScriptRoot "podcast.psd1"
Import-Module $module