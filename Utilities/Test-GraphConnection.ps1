<#
.SYNOPSIS
Validates Microsoft Graph connectivity and permissions.

.DESCRIPTION
Connects to Microsoft Graph and confirms the current context,
tenant, and granted scopes.

.EXAMPLE
.\Test-GraphConnection.ps1
#>

Connect-MgGraph
Get-MgContext
