$oAuthConsumerKey = "oH0FzA1tLdqcsBLmsgTJLoeGr "
$oAuthConsumerSecret = "gO44O2kr6Dn2z2vVKyhex6Rw2fjpOTheqMqAujg1hjKgVLlgW4"
$BearerToken = "$oAuthConsumerKey" + ":" + "$oAuthConsumerSecret"
$uri = "https://api.twitter.com/oauth2/token"
$Base64BearerToken = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($BearerToken))
$body = "grant_type=client_credentials"
$contenttype = "application/x-www-form-urlencoded;charset=UTF-8"
$Response = Invoke-RestMethod -Method POST -uri $uri -Headers @{Authorization = ("Basic {0}" -f $Base64BearerToken)} -Body $body -ContentType $contenttype
Write-Host "access_token: " $Response.access_token -ForegroundColor Green
Write-Host $Response


#GET statuses/user_timeline
#https://dev.twitter.com/rest/reference/get/statuses/user_timeline
#Authorization: Bearer access_token
$uri = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=andresbohren&count=10"
Invoke-RestMethod -Method GET -uri $uri -Headers @{Authorization = ("Bearer {0}" -f $Response.access_token)} | ft id, created_at, text -AutoSize
