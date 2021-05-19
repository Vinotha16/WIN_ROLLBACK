$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Camera -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
#  	18.9.12.1 (L2) - Ensure 'Allow Use of Camera' is set to 'Disabled' (Scored)

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Camera")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Camera" 2> $null | select-string 'AllowCamera' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Camera" | select-string 'AllowCamera').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x0' ) {
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
