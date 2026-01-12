<#
.SYNOPSIS
Exports Intune device compliance data to CSV.

.DESCRIPTION
Retrieves managed device data from Microsoft Intune using Microsoft Graph
and exports compliance status and ownership details.

.REQUIREMENTS
Microsoft.Graph
Permission: DeviceManagementManagedDevices.Read.All

.EXAMPLE
.\Get-IntuneDeviceCompliance.ps1

.EXAMPLE
.\Get-IntuneDeviceCompliance.ps1 -OnlyNonCompliant
#>
