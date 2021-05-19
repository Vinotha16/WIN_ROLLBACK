#  	9.3.7 (L1) - Ensure 'Windows Firewall: Public: Logging: Name' is set to '%SYSTEMROOT%\System32\logfiles\firewall\Publicfw.log' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

	$sid = (whoami /user | select-string 'S-').ToString().Split('')[1].Trim()
	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging" 2> $null | select-string ' LogFilePath' 2> $null |  Measure-Object | %{$_.Count})
	
	
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging" | select-string ' LogFilePath').ToString().Split('')[12].Trim() ) {
			if ( [string]$unique1 -eq [string]'%SYSTEMROOT%\System32\logfiles\firewall\Publicfw.log' ) {
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