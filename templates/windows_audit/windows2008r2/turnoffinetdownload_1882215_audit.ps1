
#  	18.8.22.1.5 (L1) - Ensure 'Turn off Internet download for Web publishing and online ordering wizards' is set to 'Enabled'
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2> $null | select-string 'NoWebServices' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" | select-string 'NoWebServices').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x1' ) {
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
	
	

