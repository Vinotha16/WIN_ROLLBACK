#  	18.5.14.1 (L1) - Ensure 'Hardened UNC Paths' is set to 'Enabled, with "Require Mutual Authentication" and "Require Integrity" set for all NETLOGON and SYSVOL shares' 
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths" 2> $null | select-string 'NETLOGON' 2> $null |  Measure-Object | %{$_.Count})
$unique1 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths" 2> $null | select-string 'SYSVOL' 2> $null |  Measure-Object | %{$_.Count})
	
if (( $path -eq 'True' ) -And ( $unique -eq '1' ) -And ( $unique1 -eq '1' )) {
	foreach ( $unique2 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths" | select-string 'NETLOGON') | Foreach {"$(($_ -split '\s+',4)[3])"} | select-string 'RequireMutualAuthentication=1, RequireIntegrity=1' | Measure-Object | %{$_.Count} ) {
		foreach ( $unique3 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths" | select-string 'SYSVOL') | Foreach {"$(($_ -split '\s+',4)[3])"} | select-string 'RequireMutualAuthentication=1, RequireIntegrity=1' | Measure-Object | %{$_.Count}) {
		if (( $unique2 -eq  '1' ) -And ( $unique3 -eq '1' )){
			Write-Output "PASSED"
		} else {
   Write-Output "FAILED"
			}
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



