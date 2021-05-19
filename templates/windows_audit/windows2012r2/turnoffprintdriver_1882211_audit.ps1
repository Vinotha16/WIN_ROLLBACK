 
#  	18.8.22.1.1 (L1) - Ensure 'Turn off downloading of print drivers over HTTP' is set to 'Enabled'

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Printers" 2> $null | select-string 'DisableWebPnPDownload.*0x1' 2> $null |  Measure-Object | %{$_.Count})
	if ( $unique -eq '1' ) {
				Write-Output "PASSED"
	} else {
    Write-Output "FAILED"
	}
	
}
Catch [System.Management.Automation.ItemNotFoundException]
{
    Write-Output "FAILED"
 }
Finally { $ErrorActionPreference = "Continue" }	
	
							
	


