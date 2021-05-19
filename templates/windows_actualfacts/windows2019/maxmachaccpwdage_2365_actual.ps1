#   2.3.6.5 (L1) - Ensure 'Domain member: Maximum machine account password age' is set to '30 or fewer days, but not 0' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters" 2> $null | select-string 'MaximumPasswordAge' 2> $null |  Measure-Object | %{$_.Count})
if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters" | select-string 'MaximumPasswordAge').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x1e' ) {
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
