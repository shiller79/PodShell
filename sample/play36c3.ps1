(Get-FyydCollection -id 1317).podcasts | Get-FyydPodcastEpisodes -count 5 | 
  Where-Object pubdate -gt (Get-Date).AddDays(-3) | 
  Sort-Object -Property pubdate |
  Out-GridView -PassThru |
  Export-PodloveWebplayerJson | Start-PodloveWebPlayer