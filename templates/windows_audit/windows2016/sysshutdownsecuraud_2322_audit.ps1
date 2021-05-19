#   2.3.2.2 (L1) - Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Disabled' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\System\Currentcontrolset\Control\Lsa' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\System\Currentcontrolset\Control\Lsa")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\System\Currentcontrolset\Control\Lsa" 2> $null | select-string 'CrashOnAuditFail' 2> $null |  Measure-Object | %{$_.Count})
if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\System\Currentcontrolset\Control\Lsa" | select-string 'CrashOnAuditFail').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x0' ) {
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