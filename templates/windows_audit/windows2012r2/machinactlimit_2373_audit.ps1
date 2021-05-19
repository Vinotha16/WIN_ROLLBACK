#   2.3.7.3 (L1) - Ensure 'Interactive logon: Machine inactivity limit' is set to '900 or fewer second(s), but not 0' (Scored)

$ErrorActionPreference = "stop"
Try {
Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" 2> $null | select-string 'InactivityTimeoutSecs' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" | select-string 'InactivityTimeoutSecs').ToString().Split('')[12].Trim() ) {
	if (  ( [int]$unique1 -le [int]'0x384' ) -And ( [int]$unique1 -ne [int]'0x0' ) ) {
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
