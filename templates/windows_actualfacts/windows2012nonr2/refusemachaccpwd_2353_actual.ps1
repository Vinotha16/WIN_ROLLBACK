#   2.3.5.3 (L1) - Ensure 'Domain controller: Refuse machine account password changes' is set to 'Disabled' (DC only) (Scored)
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" 2> $null | select-string 'RefusePasswordChange' 2> $null |  Measure-Object | %{$_.Count})
if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" | select-string 'RefusePasswordChange').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x0' ) {
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