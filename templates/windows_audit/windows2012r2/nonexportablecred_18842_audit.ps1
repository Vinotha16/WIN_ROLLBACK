
#  	18.8.4.2 (L1) - Ensure 'Remote host allows delegation of non-exportable credentials' is set to 'Enabled' 
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" 2> $null | select-string 'AllowProtectedCreds' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" | select-string 'AllowProtectedCreds').ToString().Split('')[12].Trim() ) {
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
	


