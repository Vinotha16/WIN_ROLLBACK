#   2.3.9.1 (L1) Ensure 'Microsoft network server: Amount of idle time required before suspending session' is set to '15 or fewer minute(s)' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\System\Currentcontrolset\Services\Lanmanserver\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\System\Currentcontrolset\Services\Lanmanserver\Parameters")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\System\Currentcontrolset\Services\Lanmanserver\Parameters" 2> $null | select-string 'AutoDisconnect' 2> $null |  Measure-Object | %{$_.Count})
if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\System\Currentcontrolset\Services\Lanmanserver\Parameters" | select-string 'AutoDisconnect').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0xf' ) {
		Write-Output $unique1
	} else {
		Write-Output ""
		}
	}
}else {
	Write-Output ""
}
}
Catch [System.Management.Automation.ItemNotFoundException]
{
  Write-Output ""
 }
Finally { $ErrorActionPreference = "Continue" }
