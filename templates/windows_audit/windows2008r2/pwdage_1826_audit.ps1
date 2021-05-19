#   18.2.6 (L1) - Ensure 'Password Settings: Password Age (Days)' is set to 'Enabled: 30 or fewer' (MS only) 
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{


$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft Services\AdmPwd")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft Services\AdmPwd" 2> $null | select-string 'PasswordAgeDays' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft Services\AdmPwd" | select-string 'PasswordAgeDays').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -le [int]'0x1e' ) {
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
