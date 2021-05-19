
#   18.2.5 (L1) - Ensure 'Password Settings: Password Length' is set to 'Enabled: 15 or more' (MS only)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd' -Name version 
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft Services\AdmPwd")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft Services\AdmPwd" 2> $null | select-string 'PasswordLength' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft Services\AdmPwd" | select-string 'PasswordLength').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -ge [int]'0xf' ) {
				Write-Output $unique1
			} else {
			$unique1 = $unique1 -replace '0x',''
			Write-Output $unique1
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




