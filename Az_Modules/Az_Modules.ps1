<#
.SYNOPSIS
The Az Modules natively support Managed Identity. 
#>

#Requires -Modules Az.Accounts,Az.Storage

## Auth using Az.Accounts
$VerbosePreference = "SilentlyContinue"
Connect-AzAccount -identity

## Workload Demo
Get-AzStorageAccount