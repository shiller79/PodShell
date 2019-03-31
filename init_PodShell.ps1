Remove-Module PodShell -ErrorAction:SilentlyContinue

$module = Join-Path $PSScriptRoot "PodShell.psd1"
Import-Module $module