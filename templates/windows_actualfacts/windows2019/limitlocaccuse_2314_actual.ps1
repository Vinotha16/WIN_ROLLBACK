#   2.3.1.4 (L1) - Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set to 'Enabled' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\System\Currentcontrolset\Control\Lsa' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\System\Currentcontrolset\Control\Lsa")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\System\Currentcontrolset\Control\Lsa" 2> $null | select-string 'LimitBlankPasswordUse' 2> $null |  Measure-Object | %{$_.Count})
if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\System\Currentcontrolset\Control\Lsa" | select-string 'LimitBlankPasswordUse').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x1' ) {
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