$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\EMET\SysSettings -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{


#  	18.9.24.2 (L1) Ensure 'Default Action and Mitigation Settings' is set to 'Enabled' (plus subsettings) (Scored)

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings" 2> $null | select-string 'AntiDetours' 2> $null |  Measure-Object | %{$_.Count})
	$unique1 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings" 2> $null | select-string 'BannedFunctions' 2> $null |  Measure-Object | %{$_.Count})
	$unique2 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings" 2> $null | select-string 'DeepHooks' 2> $null |  Measure-Object | %{$_.Count})
	$unique3 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings" 2> $null | select-string 'ExploitAction' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' ) -And ( $unique1 -eq '1' ) -And ( $unique2 -eq '1' ) -And ( $unique3 -eq '1' )) {
		foreach ( $unique4 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings" | select-string 'AntiDetours').ToString().Split('')[12].Trim() ) {
			foreach ( $unique5 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings" | select-string 'BannedFunctions').ToString().Split('')[12].Trim() ) {
				foreach ( $unique6 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings" | select-string 'DeepHooks').ToString().Split('')[12].Trim() ) {
					foreach ( $unique7 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings" | select-string 'ExploitAction').ToString().Split('')[12].Trim() ) {

						if ( ( [int]$unique4 -eq [int]'1' )  -And ( [int]$unique5 -eq [int]'1' ) -And ( [int]$unique6 -eq [int]'1' ) -And ( [int]$unique7 -eq [int]'2' ) ) {
							Write-Output $unique4,$unique5,$unique6,$unique7
						} else {
							Write-Output "failed $unique4,$unique5,$unique6,$unique7"
						}
					}
				}
			}	
		}
	}else {
			   $unique1 = $unique1 -replace '0x',''
			Write-Output $unique1
	}
}
Catch [System.Management.Automation.ItemNotFoundException]
{
 
  Write-Output "DELETE"
 }
Finally { $ErrorActionPreference = "Continue" }
