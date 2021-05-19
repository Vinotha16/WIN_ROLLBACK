$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\EMET\Defaults' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

#   18.9.24.4 (L1) Ensure 'Default Protections for Popular Software' is set to 'Enabled' (Scored)

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\Defaults")
$unique = (get-itemproperty -literalpath HKLM:\SOFTWARE\Policies\Microsoft\EMET\Defaults).'(default)' 

if ( $path -eq 'True' ) {
	if ( [int]$unique -eq [int]'1' ) {
		Write-Output "PASSED"
	} else {
		Write-Output "FAILED"
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

