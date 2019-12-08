class Twitter {
    [long]$id
    [string]$date
    [string]$user
    [string]$text
    [string[]]$url
}
#$twitterkeys = Get-MyTwitterConfiguration

function Invoke-TwitterAPI {
    param (
        $HttpEndPoint = "https://api.twitter.com/1.1/statuses/home_timeline.json",
        $SinceId
    )

    $ApiParams = @{'count' = '100' }
            
    if ($SinceId -gt 0) {
        $ApiParams.Add('since_id', $SinceId)
    }
    
    $AuthorizationString = Get-OAuthAuthorization -Api 'Timeline' -ApiParameters $ApiParams -HttpEndPoint $HttpEndPoint -HttpVerb GET
            
    $HttpRequestUrl = $HttpEndPoint + "?"
    $ApiParams.GetEnumerator() | Sort-Object name | ForEach-Object { $HttpRequestUrl += "{0}={1}&" -f $_.Key, $_.Value }
    $HttpRequestUrl = $HttpRequestUrl.Trim('&')
    Write-Host "HTTP request URL is '$HttpRequestUrl'"
    $tweets = Invoke-RestMethod -URI $HttpRequestUrl -Method Get -Headers @{ 'Authorization' = $AuthorizationString } -ContentType "application/json"

    return $tweets
}


$twitteridfile = Join-Path $env:APPDATA "podshell\twitterid.txt"
if (Test-Path -Path $twitteridfile) {
    $SinceId = Get-Content $twitteridfile
}

#$SinceId = 1151040043571666943
#1151585326323982337

$tweets = Invoke-TwitterAPI -HttpEndPoint "https://api.twitter.com/1.1/statuses/home_timeline.json" -SinceId $SinceId

[Twitter[]]$tweetarray = @()
foreach ($tweet in $tweets) {
    [Twitter]$tweedobject = [Twitter]::new()
    $tweedobject.id = $tweet.id
    $tweedobject.user = $tweet.user.screen_name
    $tweedobject.date = $tweet.created_at
    $tweedobject.text = $tweet.text
    $tweedobject.url = $tweet.entities.urls.expanded_url
    $tweetarray += $tweedobject
}


#Save last TweetID to file
if (-Not (Test-Path -Path (Join-Path $env:APPDATA "podshell") -pathType container)) {
    New-Item -Path (Join-Path $env:APPDATA "podshell") -ItemType directory
}
Set-Content -path  $twitteridfile -Value $tweetarray[0].id

$tweetarray

$urls = $tweetarray.url | Where-Object { $_ -NotLike "https://twitter.com/*" }
$urls