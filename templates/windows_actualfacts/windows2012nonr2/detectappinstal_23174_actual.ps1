#  2.3.17.4 (L1) - Ensure 'User Account Control: Detect application installations and prompt for elevation' is set to 'Enabled' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" 2> $null | select-string 'EnableInstallerDetection' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" | select-string 'EnableInstallerDetection').ToString().Split('')[12].Trim() ) {
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

