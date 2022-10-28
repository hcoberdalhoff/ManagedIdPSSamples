#Requires -Modules Az.Accounts,ExchangeOnlineManagement

## Auth using Az.Accounts
$VerbosePreference = "SilentlyContinue"
Connect-azaccount -identity
$context = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile.DefaultContext
$accessToken = [Microsoft.Azure.Commands.Common.Authentication.AzureSession]::Instance.AuthenticationFactory.Authenticate($context.Account, $context.Environment, $context.Tenant.Id.ToString(), $null, [Microsoft.Azure.Commands.Common.Authentication.ShowDialog]::Never, $null, "https://outlook.office365.com/").AccessToken

## Immitate a user logging in
# see https://stackoverflow.com/questions/63953702/access-o365-exchange-online-with-an-azure-managed-identity-or-service-principal
$Authorization = "Bearer $accessToken"
$Password = ConvertTo-SecureString -AsPlainText $Authorization -Force
$Ctoken = New-Object System.Management.Automation.PSCredential -ArgumentList "OAuthUser@$($context.Tenant.Id)",$Password

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/PowerShell-LiveId?BasicAuthToOAuthConversion=true" -Credential $Ctoken -Authentication Basic -AllowRedirection -Verbose
Import-PSSession $Session | Out-Null

## Workload Demo
Get-Mailbox 

## End Session
Remove-PSSession $Session | Out-Null