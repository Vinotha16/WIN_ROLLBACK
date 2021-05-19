
#  	18.9.80.1.1 (L1) - Ensure 'Configure Windows Defender SmartScreen' is set to 'Enabled: Warn and prevent bypass' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System'  -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System")

	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" 2> $null | select-string 'EnableSmartScreen' 2> $null |  Measure-Object | %{$_.Count})
	$unique1 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" 2> $null | select-string 'ShellSmartScreenLevel' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' ) -And ( $unique1 -eq '1' )) {
		foreach ( $unique2 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" 2> $null | select-string 'EnableSmartScreen').ToString().Split('')[12].Trim() ) {
			foreach ( $unique3 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" 2> $null | select-string 'ShellSmartScreenLevel').ToString().Split('')[12].Trim() ) {
				if ( ( [string]$unique2 -eq [string]'0x1' ) -And ( [string]$unique3 -eq [string]'Block' ) ) {
					Write-Output "PASSED"
				} else {
    Write-Output "FAILED"
					}
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