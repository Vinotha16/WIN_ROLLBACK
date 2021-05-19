
#   18.5.4.1 (L1) - Ensure 'Turn off multicast name resolution' is set to 'Enabled' (MS Only)
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

    $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" 2> $null | select-string 'EnableMulticast' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" | select-string 'EnableMulticast').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -le [int]'0x1' ) {
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

	
	


