$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\EMET\SysSettings' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

#   18.9.24.8 (L1) Ensure 'System SEHOP' is set to 'Enabled: Application OptOut' (Scored)

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings" 2> $null | select-string 'SEHOP' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings" | select-string 'SEHOP').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x2' ) {
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

