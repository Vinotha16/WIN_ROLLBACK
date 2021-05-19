$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

#   18.4.6 (L1) - Ensure 'MSS: (NoNameReleaseOnDemand) Allow the computer to ignore NetBIOS name release requests except from WINS servers' is set to 'Enabled' 

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" 2> $null | select-string 'NoNameReleaseOnDemand' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" | select-string 'NoNameReleaseOnDemand').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x1' ) {
		Write-Output $unique1
	} else {
		Write-Output $unique1
		}
	}
}else {
	Write-Output "DELETE"
}

}

Catch [System.Management.Automation.ItemNotFoundException]
{
 
  Write-Output "DELETE"
 }
Finally { $ErrorActionPreference = "Continue" }
