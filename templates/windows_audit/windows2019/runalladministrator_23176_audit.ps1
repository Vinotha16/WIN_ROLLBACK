#   2.3.17.6 (L1) - Ensure 'User Account Control: Run all administrators in Admin Approval Mode' is set to 'Enabled' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" 2> $null | select-string 'EnableLUA' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" | select-string 'EnableLUA').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x1' ) {
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


