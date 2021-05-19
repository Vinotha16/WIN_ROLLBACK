$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\kerberos\parameters -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
#  	18.8.25.1 (L2) Ensure 'Support device authentication using certificate' is set to 'Enabled: Automatic' (Scored)

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\kerberos\parameters")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\kerberos\parameters" 2> $null | select-string 'DevicePKInitBehavior' 2> $null |  Measure-Object | %{$_.Count})
	$unique1 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\kerberos\parameters" 2> $null | select-string 'DevicePKInitEnabled' 2> $null |  Measure-Object | %{$_.Count})

	if (( $path -eq 'True' ) -And ( $unique -eq '1' ) -And ( $unique -eq '1' ) ) {
		foreach ( $unique2 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\kerberos\parameters" | select-string 'DevicePKInitBehavior').ToString().Split('')[12].Trim() ) {
			foreach ( $unique3 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\kerberos\parameters" | select-string 'DevicePKInitEnabled').ToString().Split('')[12].Trim() ) {
				if ( ( [int]$unique2 -eq [int]'0x0' ) -And ( [int]$unique3 -eq [int]'0x1' ) ) {
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
