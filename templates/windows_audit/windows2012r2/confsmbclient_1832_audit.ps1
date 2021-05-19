
#   18.3.2 (L1) - Ensure 'Configure SMB v1 client driver' is set to 'Enabled: Disable driver'
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\mrxsmb10' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

    $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mrxsmb10")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mrxsmb10" 2> $null | select-string 'Start' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mrxsmb10" | select-string 'Start').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x4' ) {
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


	


