#Requires -Modules Az.Accounts,Az.Storage

## Auth using Az.Accounts
$VerbosePreference = "SilentlyContinue"
Connect-azaccount -identity

## Workload Demo
Get-AzStorageAccount