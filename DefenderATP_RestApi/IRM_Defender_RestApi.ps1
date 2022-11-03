<#
 .SYNOPSIS
 This sample demontrates interacting with the DefenderATP / MS Defender for Endpoint API. 
 This sample directly calls the Managed Identity a token and will use this for alls API calls. 
 #>

## Auth (directly calling managed id auth. endpoint)
$resourceURL = "https://api.securitycenter.microsoft.com" 
$authUri = $env:IDENTITY_ENDPOINT
$headers = @{'X-IDENTITY-HEADER' = "$env:IDENTITY_HEADER"}

$AuthResponse = Invoke-WebRequest -UseBasicParsing -Uri "$($authUri)?resource=$($resourceURL)" -Method 'GET' -Headers $headers
$accessToken = ($AuthResponse.content | ConvertFrom-Json).access_token

$authHeader = @{
    'Content-Type'  = 'application/json'
    'Authorization' = "Bearer " + $accessToken
}

## Workload Demo
(Invoke-RestMethod -Method Get -Uri "https://api.securitycenter.microsoft.com/api/machines" -Headers $authHeader).Value