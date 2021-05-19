
#  	18.9.77.3.2 (L2) - Ensure 'Join Microsoft MAPS' is set to 'Disabled' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet'  -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{	
	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet")

$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" 2> $null | select-string 'SpynetReporting' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" | select-string 'SpynetReporting').ToString().Split('')[12].Trim() ) {
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