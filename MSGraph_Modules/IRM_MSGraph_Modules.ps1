<#
.SYNOPSIS
Use direct REST-calls to create an AccessToken for MS Graph PowerShell SDK.
#>

#Requires -modules Microsoft.Graph.Authentication,Microsoft.Graph.Identity.DirectoryManagement

## Auth (directly calling auth endpoint)
$resourceURL = "https://graph.microsoft.com/" 
$authUri = $env:IDENTITY_ENDPOINT
$headers = @{'X-IDENTITY-HEADER' = "$env:IDENTITY_HEADER"}

$AuthResponse = Invoke-WebRequest -UseBasicParsing -Uri "$($authUri)?resource=$($resourceURL)" -Method 'GET' -Headers $headers
$accessToken = ($AuthResponse.content | ConvertFrom-Json).access_token

#Connect to the Microsoft Graph using the aquired AccessToken
Connect-MgGraph -AccessToken $accessToken

## Workload Demo
Get-MgDirectoryRole