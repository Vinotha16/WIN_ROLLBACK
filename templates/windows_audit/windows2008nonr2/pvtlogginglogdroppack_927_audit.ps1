#  	9.2.7 (L1) - Ensure 'Windows Firewall: Private: Logging: Log dropped packets' is set to 'Yes' (Scored)

	$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
	
	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging" 2> $null | select-string ' LogDroppedPackets' 2> $null |  Measure-Object | %{$_.Count})
	
	
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging" | select-string ' LogDroppedPackets').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -ge [int]'0x1' ) {
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