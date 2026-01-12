<#
.SYNOPSIS
Retrieves the primary user for an Intune managed device.

.DESCRIPTION
Uses Microsoft Graph to query Intune managed devices by device name
and returns the associated userPrincipalName.

.REQUIREMENTS
Microsoft.Graph
Permission: DeviceManagementManagedDevices.Read.All

.PARAMETER DeviceName
The name of the Intune managed device.

.EXAMPLE
.\Get-IntunePrimaryUser.ps1 -DeviceName "CORP-LAPTOP-123"
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]$DeviceName
)

$ErrorActionPreference = 'Stop'

# Ensure Graph module is available
if (-not (Get-Module -ListAvailable Microsoft.Graph)) {
    Install-Module Microsoft.Graph -Scope CurrentUser -Force
}
Import-Module Microsoft.Graph

# Connect to Graph
Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All" -NoWelcome | Out-Null

# Query device
$device = Get-MgDeviceManagementManagedDevice `
    -Filter "deviceName eq '$DeviceName'" `
    -Property "deviceName,userPrincipalName,id" `
    -ErrorAction Stop

if (-not $device) {
    Write-Warning "No device found with name: $DeviceName"
    return
}

[pscustomobject]@{
    DeviceName        = $device.deviceName
    PrimaryUser       = $device.userPrincipalName
    ManagedDeviceId   = $device.id
}
