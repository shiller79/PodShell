$nulldates = Get-FyydCurationEpisodes -id 609 | Select-Object @{Name = "pubdate"; Expression = {[DateTime]::Parse($_.pubdate)}}, duration
$nulldates | Group-Object -Property {$_.pubdate.toString("yyyy-MM")}
($nulldatesm | Sort-Object -Property name)[9..17]| % {($_.Group) | Measure-Object duration -Sum } | Measure-Object Sum -Average
