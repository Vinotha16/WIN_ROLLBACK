 #  	18.9.102.7 (L1) Ensure 'Reschedule Automatic Updates scheduled installations' is set to 'Enabled 1 minute'
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'  -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" 2> $null | select-string 'RescheduleWaitTimeEnabled' 2> $null |  Measure-Object | %{$_.Count})
$unique1 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" 2> $null | select-string 'RescheduleWaitTime ' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' ) -And ( $unique1 -eq '1' )) {
	foreach ( $unique2 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" 2> $null | select-string 'RescheduleWaitTimeEnabled').ToString().Split('')[12].Trim() ) {
		foreach ( $unique3 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" 2> $null | select-string 'RescheduleWaitTime ').ToString().Split('')[12].Trim() ) {
		if ( ( [int]$unique2 -eq [int]'0x1' ) -And ( [int]$unique3 -eq [int]'0x1' ) ) {
			Write-Output $unique2,$unique3
		} else {
			$unique1 = $unique1 -replace '0x',''
		Write-Output $unique1
			}
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
