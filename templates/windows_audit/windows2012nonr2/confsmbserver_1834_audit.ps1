
#   18.3.4 (L1) - Ensure 'Configure SMB v1 server' is set to 'Disabled'
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" 2> $null | select-string 'SMB1' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" | select-string 'SMB1').ToString().Split('')[12].Trim() ) {
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

	


