
#  	18.8.22.1.4 (L2) - Ensure 'Turn off Internet Connection Wizard if URL connection is referring to Microsoft.com' is set to 'Enabled'
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Internet Connection Wizard' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Internet Connection Wizard")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Internet Connection Wizard" 2> $null | select-string 'ExitOnMSICW' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Internet Connection Wizard" | select-string 'ExitOnMSICW').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x1' ) {
				Write-Output $unique1
			} else {
		$unique1 = $unique1 -replace '0x',''
		Write-Output $unique1
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
	
	


