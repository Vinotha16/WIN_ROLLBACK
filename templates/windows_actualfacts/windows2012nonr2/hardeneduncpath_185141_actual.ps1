#  	18.5.14.1 (L1) - Ensure 'Hardened UNC Paths' is set to 'Enabled, with "Require Mutual Authentication" and "Require Integrity" set for all NETLOGON and SYSVOL shares' (Scored) 
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
	foreach ( $unique2 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths" | select-string 'NETLOGON') | Foreach {"$(($_ -split '\s+',4)[3])"}) {
		foreach ( $unique3 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths" | select-string 'SYSVOL') | Foreach {"$(($_ -split '\s+',4)[3])"}) {
		if (( $unique2 -eq  '1' ) -And ( $unique3 -eq '1' )){
			Write-Output $unique2,$unique3 
		} else {
			Write-Output $unique2,$unique3 
			}
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
