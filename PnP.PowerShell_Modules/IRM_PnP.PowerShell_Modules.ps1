<#
 .SYNOPSIS
 Use direct REST-calls to create an AccessToken for the PnP.PowerShell module.
#>

#Requires -Modules "PnP.PowerShell"

param(
    # Please specify the SharePoint Tenant to work on
    $resourceURL = "https//tenant.sharepoint.com"
)

## Authenticating as managed Identity...

## Sadly, not yet working...
#Connect-PnPOnline -ManagedIdentity -URL $SharePointContext

## Auth (directly calling auth endpoint)
$authUri = $env:IDENTITY_ENDPOINT
$headers = @{'X-IDENTITY-HEADER' = "$env:IDENTITY_HEADER" ; 'Metadata' = 'True'}

$AuthResponse = Invoke-WebRequest -UseBasicParsing -Uri "$($authUri)?resource=$($resourceURL)" -Method 'GET' -Headers $headers
$accessToken = ($AuthResponse.content | ConvertFrom-Json).access_token

## Conencting to SharePoint
Connect-PnPOnline -URL $SharePointContext -AccessToken $AccessToken

## Workload Demo
New-PnPSite -Type "CommunicationSite" -Title "Demo" -URL "https//tenant.sharepoint.com/sites/demo" -Description "Demo" -owner "someuser@demo.com" -ErrorAction Stop

## Disconnect from SharePoint
Disconnect-PnPOnline

