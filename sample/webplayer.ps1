$fs = Get-FyydEpisode -id 3444593
$fs | Export-WebplayerJson | Start-PodloveWebplayer