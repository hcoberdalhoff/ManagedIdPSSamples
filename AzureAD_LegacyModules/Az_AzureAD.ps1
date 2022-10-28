<#
 .SYNOPSIS
 This sample uses the Az modules to create a token and will use it to create a "legacy" AadAccessToken to go the legacy AzureAD module. Only tested on Windows Powershell 5.1. Do not use the AzureAD module anymore - please ;)
#>

#Requires -Modules Az.Accounts,AzureAD

## Auth using Az.Accounts
Connect-AzAccount -identity
$context = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile.DefaultContext
$aadToken = [Microsoft.Azure.Commands.Common.Authentication.AzureSession]::Instance.AuthenticationFactory.Authenticate($context.Account, $context.Environment, $context.Tenant.Id.ToString(), $null, [Microsoft.Azure.Commands.Common.Authentication.ShowDialog]::Never, $null, "https://graph.windows.net").AccessToken

# AzureAD module wants to know the Managed Identity's account info.
Write-Output "Hi I'm $($context.Account.Id)"
Connect-AzureAD -AadAccessToken $aadToken -AccountId $context.Account.Id -TenantId $context.tenant.id

## Workload Demo
Get-AzureADGroup