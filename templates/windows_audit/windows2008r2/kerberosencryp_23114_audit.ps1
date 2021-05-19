#   2.3.11.4 (L1) - Ensure 'Network security: Configure encryption types allowed for Kerberos' is set to 'AES128_HMAC_SHA1, AES256_HMAC_SHA1, Future encryption types' (Scored)

$ErrorActionPreference = "stop"
Try {
Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters" 2> $null | select-string 'SupportedEncryptionTypes' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters" | select-string 'SupportedEncryptionTypes').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x7ffffff8' )  {
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