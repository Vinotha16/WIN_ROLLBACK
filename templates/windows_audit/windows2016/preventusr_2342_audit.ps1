#   2.3.4.2 (L1) - Ensure 'Devices: Prevent users from installing printer drivers' is set to 'Enabled' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\System\Currentcontrolset\Control\Print\Providers\Lanman Print Services\Servers' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
 $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\System\Currentcontrolset\Control\Print\Providers\Lanman Print Services\Servers")
 $unique = (REG QUERY "HKEY_LOCAL_MACHINE\System\Currentcontrolset\Control\Print\Providers\Lanman Print Services\Servers" 2> $null | select-string 'AddPrinterDrivers' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\System\Currentcontrolset\Control\Print\Providers\Lanman Print Services\Servers" | select-string 'AddPrinterDrivers').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x1' ) {
		Write-Output "PASSED"
	} else {
		Write-Output "FAILED"
		}
	}
}else {
	Write-Output "FAILED"
}


}
Catch [System.Management.Automation.ItemNotFoundException]
{
  Write-Output "FAILED"
 }
Finally { $ErrorActionPreference = "Continue" }
