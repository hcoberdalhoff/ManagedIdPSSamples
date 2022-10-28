# This script is purely theoretical/POC. Most voice related things do not work in this scenario.

#Requires -Modules MicrosoftTeams

## Auth - The Teams module can natively use a managed identity
$VerbosePreference = "SilentlyContinue"
Connect-MicrosoftTeams -Identity

## Workload Demos
#Working
Get-Team

#Non Working - MS Teams module/service still needs a "real" admin user for most Voice-related tasks
Get-CsOnlineUser
