#  	18.5.21.1 (L1) - Ensure 'Minimize the number of simultaneous connections to the Internet or a Windows Domain' is set to 'Enabled'

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy" 2> $null | select-string 'fMinimizeConnections' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy" | select-string 'fMinimizeConnections').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x3' ) {
				Write-Output $unique1
			} else {
				Write-Output ""
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
	

