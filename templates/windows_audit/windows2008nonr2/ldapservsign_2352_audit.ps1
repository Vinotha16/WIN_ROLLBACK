#   2.3.5.2 (L1) - Ensure 'Domain controller: LDAP server signing requirements' is set to 'Require signing' (DC only) (Scored)

$ErrorActionPreference = "stop"
Try {
Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" 2> $null | select-string 'LDAPServerIntegrity' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" | select-string 'LDAPServerIntegrity').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x2' ) {
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