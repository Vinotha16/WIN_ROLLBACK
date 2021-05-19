
#   18.4.8 (L1) - Ensure 'MSS: (SafeDllSearchMode) Enable Safe DLL search mode (recommended)' is set to 'Enabled' 

	$output = '1'
	$output1= '0x1'
	$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
        $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" | select-string 'SafeDllSearchMode' 2> $null |  Measure-Object | %{$_.Count})
	if ( ( $path -eq 'True' ) -And ( $unique -eq $output ) ) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" | select-string 'SafeDllSearchMode').ToString().Split('')[12].Trim() ) {
			if ( $unique1 -eq $output1 ) {
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
	
	


