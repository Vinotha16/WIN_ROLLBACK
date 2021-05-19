#  	18.9.101.3 (L1) Ensure 'Configure Automatic Updates: Scheduled install day' is set to '0 - Every day' 

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" 2> $null | select-string 'ScheduledInstallDay' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" | select-string 'ScheduledInstallDay').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x0' ) {
		write-Output $unique1
	} else {
		Write-Output $unique1
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