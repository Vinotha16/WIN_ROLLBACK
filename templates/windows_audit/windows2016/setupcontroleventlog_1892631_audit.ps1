$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Setup -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
#  	18.9.26.3.1 (L1) - Ensure 'Setup: Control Event Log behavior when the log file reaches its maximum size' is set to 'Disabled' (Scored)

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\Setup")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\Setup" 2> $null | select-string 'Retention' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\Setup" | select-string 'Retention').ToString().Split('')[12].Trim() ) {
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
