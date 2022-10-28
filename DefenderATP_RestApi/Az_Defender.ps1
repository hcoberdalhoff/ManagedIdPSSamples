#Requires -Modules Az.Accounts

## Auth using Az.Accounts
Connect-azaccount -identity
$context = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile.DefaultContext
$accessToken = [Microsoft.Azure.Commands.Common.Authentication.AzureSession]::Instance.AuthenticationFactory.Authenticate($context.Account, $context.Environment, $context.Tenant.Id.ToString(), $null, [Microsoft.Azure.Commands.Common.Authentication.ShowDialog]::Never, $null, "https://api.securitycenter.microsoft.com").AccessToken

$authHeader = @{
    'Content-Type'  = 'application/json'
    'Authorization' = "Bearer " + $accessToken
}

## Workload Demo
(Invoke-RestMethod -Method Get -Uri "https://api.securitycenter.microsoft.com/api/machines" -Headers $authHeader).Value