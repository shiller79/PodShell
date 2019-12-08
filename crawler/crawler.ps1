function find-link($message) {
    $url_regex = [Regex]::new("(http|ftp|https)://([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?")
    $links = ($url_regex.Matches($message)).Value
    return $links
}

function find-linkrel($url) {
    $Request = Invoke-WebRequest -Uri $url -UseBasicParsing
    $html = @()
    if ($Request.Headers."Content-Type" -match "html") {
        $HTML = New-Object -Com "HTMLFile"
        $HTML.IHTMLDocument2_write($Request.RawContent)
        return ($HTML.all.tags("link") | Where-Object -Property type -eq -Value "application/rss+xml").href 
    }
}

$feedurl = (Get-FyydPodcast -slug sendegarten-de).XmlUrl

$FeedXml = Get-PodcastFeed -url $feedurl

#links im Feed Finden
$links = @()
foreach ($Episode in $FeedXml.Episodes) {
    $links += find-link($Episode.Description)
    $links += find-link($Episode.DescriptionHTML)
    $links += find-link($Episode.Summary)
}

#Doppelte Links entfernen
$links = $links | Select-Object -Unique

foreach ($Link in $links) {
    #    Write-Host $Link
    find-linkrel($Link)
}

