<#
.SYNOPSIS 
Sample of using ExchangeOnlineManagement v3 Module with Managed Identity. (Recommended)
#>

#Requires -Modules ExchangeOnlineManagement

## Fetching the current AzureAD Organization / Tenant
# - Auth against MS Graph
$resourceURL = "https://graph.microsoft.com/" 
$authUri = $env:IDENTITY_ENDPOINT
$headers = @{'X-IDENTITY-HEADER' = "$env:IDENTITY_HEADER" }

$AuthResponse = Invoke-WebRequest -UseBasicParsing -Uri "$($authUri)?resource=$($resourceURL)" -Method 'GET' -Headers $headers
$accessToken = ($AuthResponse.content | ConvertFrom-Json).access_token

$authHeader = @{
    'Content-Type'  = 'application/json'
    'Authorization' = "Bearer " + $accessToken
}

# Querying tenant
$tenant = (Invoke-RestMethod -Method Get -Uri "https://graph.microsoft.com/v1.0/organization" -Headers $authHeader).Value.verifiedDomains | Where-Object { $_.isInitial } | Select-Object -First 1 -ExpandProperty name

## Connecting to ExchangeOnline
Connect-ExchangeOnline -Organization $tenant -ManagedIdentity

## Workload Demo
Get-Mailbox

## Disconnect
Disconnect-ExchangeOnline