(Get-FyydCollection -id 1141).podcasts | Get-FyydPodcastEpisodes -count 5 | 
  Where-Object {[DateTime]::Parse($_.pubdate) -gt (Get-Date).AddDays(-1)} | 
  Sort-Object -Property pubdate |Select-Object id, title, pubdate, podcast_id | Out-GridView -PassThru |
  Get-FyydEpisode