(Get-FyydCollection -id 1317).podcasts | Get-FyydPodcastEpisodes -count 5 | 
  Where-Object pubdate -gt (Get-Date).AddDays(-3) | 
  Sort-Object -Property pubdate |
  Select-Object title, pubdate, FyydEpisodeId |
  Out-GridView -PassThru |
  Set-FyydCurate -curation_id 3905