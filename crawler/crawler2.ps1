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
        ($HTML.all.tags("link") | Where-Object -Property rel -eq -Value "alternate" ).href 
    }
}


