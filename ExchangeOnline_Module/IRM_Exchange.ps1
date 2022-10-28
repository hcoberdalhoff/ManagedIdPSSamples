#Requires -Modules ExchangeOnlineManagement

## This scenario would need to get the OrgId when called.
param(
    $tenantId = "bc753e18-c1f6-4f62-84cb-cbef347d3ba8"
)

## Auth (directly calling auth endpoint)
$resourceURL = "https://outlook.office365.com/"
$authUri = $env:IDENTITY_ENDPOINT
$headers = @{'X-IDENTITY-HEADER' = "$env:IDENTITY_HEADER"}

$AuthResponse = Invoke-WebRequest -UseBasicParsing -Uri "$($authUri)?resource=$($resourceURL)" -Method 'GET' -Headers $headers

$accessToken = ($AuthResponse.content | ConvertFrom-Json).access_token

## Immitate a user logging in
# see https://stackoverflow.com/questions/63953702/access-o365-exchange-online-with-an-azure-managed-identity-or-service-principal
$Authorization = "Bearer $accessToken"
$Password = ConvertTo-SecureString -AsPlainText $Authorization -Force
$Ctoken = New-Object System.Management.Automation.PSCredential -ArgumentList "OAuthUser@$($tenantId)",$Password

$VerbosePreference = "SilentlyContinue"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/PowerShell-LiveId?BasicAuthToOAuthConversion=true" -Credential $Ctoken -Authentication Basic -AllowRedirection -Verbose
Import-PSSession $Session | Out-Null

## Workload Demo
Get-Mailbox 

## End Session
Remove-PSSession $Session | Out-Null