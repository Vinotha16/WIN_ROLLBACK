#   18.9.24.5 (L1) Ensure 'Default Protections for Recommended Software' is set to 'Enabled' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\EMET\Defaults -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\Defaults")
	$unique = ((get-itemproperty -literalpath HKLM:\SOFTWARE\Policies\Microsoft\EMET\Defaults) | select-string 'OFFICE1' 2> $null | Measure-Object | %{$_.Count})
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
	
	
	



