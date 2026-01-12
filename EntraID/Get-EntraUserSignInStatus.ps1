<#
.SYNOPSIS
Retrieves last sign-in information for Entra ID users.

.DESCRIPTION
Uses Microsoft Graph to retrieve user sign-in activity
for operational visibility and troubleshooting.

.REQUIREMENTS
Microsoft.Graph
Permission: AuditLog.Read.All

.EXAMPLE
.\Get-EntraUserSignInStatus.ps1
#>
