#Requires -Modules Az.Accounts,Microsoft.Graph.Authentication,Microsoft.Graph.Identity.DirectoryManagement

## Auth using Az.Accounts
Connect-azaccount -identity
$context = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile.DefaultContext
$accessToken = [Microsoft.Azure.Commands.Common.Authentication.AzureSession]::Instance.AuthenticationFactory.Authenticate($context.Account, $context.Environment, $context.Tenant.Id.ToString(), $null, [Microsoft.Azure.Commands.Common.Authentication.ShowDialog]::Never, $null, "https://graph.microsoft.com").AccessToken

#Connect to the Microsoft Graph using the aquired AccessToken
$VerbosePreference = "SilentlyContinue"
Connect-MgGraph -AccessToken $accessToken

## Workload Demo
Get-MgDirectoryRole