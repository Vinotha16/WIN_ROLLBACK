
#  	18.8.21.2 (L1) - Ensure 'Configure registry policy processing: Do not apply during periodic background processing' is set to 'Enabled: FALSE'
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy' -Name version 
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}" 2> $null | select-string 'NoBackgroundPolicy' 2> $null |  Measure-Object | %{$_.Count})
		if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
			foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}" | select-string 'NoBackgroundPolicy').ToString().Split('')[12].Trim() ) {
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
	
		
	
