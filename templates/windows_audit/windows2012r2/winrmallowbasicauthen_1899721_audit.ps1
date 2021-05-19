
#  	18.9.97.2.1 (L1) - Ensure 'Allow Basic authentication' is set to 'Disabled' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service'  -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{	
	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service")

$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" 2> $null | select-string 'AllowBasic' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" | select-string 'AllowBasic').ToString().Split('')[12].Trim() ) {
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