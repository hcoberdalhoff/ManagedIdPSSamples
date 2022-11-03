# ManagedIdPSSamples
Samples on how to use sys. assigned Managed Identities from PowerShell for different workloads

Demos are sorted by API / PowerShell module in folders. Every folder contains one or more samples. The samples follow the following naming scheme:
- `Az_` - This sample will use the Az PowerShell modules to create an access token.
- `IRM_` - This sample will use API-Calls (Invoke-RestMethod) to create an access token.
- `_Modules` - This sample focusses on a PowerShell module as workload
- `_RestApi` - This sample focusses on an Rest-API as workload. This is especially relevant for MS Graph which can be used directly or via its PowerShell SDK modules.

# The good...

## Az PowerShell modules
These modules natively support authenticating as Managed Identities. They allow access to basically any AzureRM-managed resource. These modules completely replace the older AzureRM modules by now btw.

See https://learn.microsoft.com/en-us/powershell/azure/new-azureps-module-az?view=azps-9.1.0

Additionally the Az modules can be leveraged to create access tokens for other modules / APIs if needed. 

## DefenderATP REST API
Aka MS Defender for Endpoint / MS SecurityCenter API.

See https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/exposed-apis-create-app-webapp?view=o365-worldwide for details about using this API in app context.

## ExchangeOnlineManagement PowerShell Module
The recent version 3.0.0 of the module gained the ability to authenticate to Managed Identity (almost) on its own. If you can, please upgrade to v3.0.0.

Two samples for older versions are included, but are much more complicated and not recommended.

Please make sure to grant the `Exchange.ManageAsApp` permission to the managed identity as well as AzureAD roles like `Exchange Administrator`. 

See https://learn.microsoft.com/en-us/powershell/exchange/app-only-auth-powershell-v2?view=exchange-ps for more details.

## MS Graph REST API and PowerShell SDK
Just working :)

For using the MS Graph Rest API see https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0

For using the MS Graph PowerShell SDK, see https://learn.microsoft.com/en-us/powershell/microsoftgraph/

## PnP.PowerShell module
The native managed identity authentication of the module was broken at the time of writing. The sample will directly fetch an access token for the API.

Please remember to pass on the SharePoint tenant you want to work on as parameter.

You can find documentation for PnP.PowerShell at https://pnp.github.io/powershell/

# ... and the others

## Microsoft Teams module (not working)
At the time of writing, support for working with access tokens exists but seems not to work with managed identities. 

You can use an AppRegistration and ClientId/ClientSecret to use App-based authentication but support for this is also incomplete: https://learn.microsoft.com/en-us/MicrosoftTeams/teams-powershell-application-authentication

Make sure the Managed Identity / Enterprise App has the required AzureAD Roles and MS Graph Permissions assigned.
https://learn.microsoft.com/en-us/MicrosoftTeams/teams-powershell-application-authentication

I guess we will need to wait some more for MS Teams (Voice) to be controllable from managed identity driven scenarios.

## AzureAD PowerShell module
If you can, please do not use the AzureAD PowerShell module anymore and migrate to MS Graph. 
https://learn.microsoft.com/en-us/graph/migrate-azure-ad-graph-overview

Especially, see 
https://learn.microsoft.com/en-us/powershell/microsoftgraph/azuread-msoline-cmdlet-map?source=recommendations&view=graph-powershell-1.0
for a mapping of AzureAD and MSOnline to MS Graph PowerShell SDK CMDlets.

The samples here are just given to help with lift and shift migrations of existing code.

