<#
.SYNOPSIS
Retrieves members of an Entra ID group.

.DESCRIPTION
Looks up a group by display name and returns its members using Microsoft Graph.

.REQUIREMENTS
Microsoft.Graph
Permission: Group.Read.All

.PARAMETER GroupName
The display name of the Entra ID group.

.EXAMPLE
.\Get-EntraGroupMembers.ps1 -GroupName "CORP-IT-Admins"
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]$GroupName
)

$ErrorActionPreference = 'Stop'

# Ensure Graph module is available
if (-not (Get-Module -ListAvailable Microsoft.Graph)) {
    Install-Module Microsoft.Graph -Scope CurrentUser -Force
}
Import-Module Microsoft.Graph

# Connect to Graph
Connect-MgGraph -Scopes "Group.Read.All" -NoWelcome | Out-Null

# Find the group
$group = Get-MgGroup -Filter "displayName eq '$GroupName'" -Property "id,displayName"

if (-not $group) {
    Write-Warning "No group found with name: $GroupName"
    return
}

# Get members
$members = Get-MgGroupMember -GroupId $group.Id -All

$members | ForEach-Object {
    [pscustomobject]@{
        GroupName        = $group.displayName
        MemberDisplayName = $_.AdditionalProperties.displayName
        MemberUPN         = $_.AdditionalProperties.userPrincipalName
        MemberType        = $_.'@odata.type' -replace '#microsoft.graph.', ''
    }
}
