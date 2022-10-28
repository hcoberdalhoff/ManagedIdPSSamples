## Auth (directly calling auth endpoint)
$resourceURL = "https://graph.microsoft.com/" 
$authUri = $env:IDENTITY_ENDPOINT
$headers = @{'X-IDENTITY-HEADER' = "$env:IDENTITY_HEADER"}

$AuthResponse = Invoke-WebRequest -UseBasicParsing -Uri "$($authUri)?resource=$($resourceURL)" -Method 'GET' -Headers $headers

$accessToken = ($AuthResponse.content | ConvertFrom-Json).access_token

$authHeader = @{
    'Content-Type'  = 'application/json'
    'Authorization' = "Bearer " + $accessToken
}

## Workload Demo
(Invoke-RestMethod -Method Get -Uri "https://graph.microsoft.com/v1.0/groups" -Headers $authHeader).Value