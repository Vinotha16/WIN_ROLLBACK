#  	18.5.20.1 (L2) - Ensure 'Configuration of wireless settings using Windows Connect Now' is set to 'Disabled' (Scored)
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars")	
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" 2> $null | select-string 'EnableRegistrars' 2> $null | Measure-Object | %{$_.Count})
$unique1 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" 2> $null | select-string 'DisableUPnPRegistrar' 2> $null | Measure-Object | %{$_.Count})
$unique2 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" 2> $null | select-string 'DisableInBand802DOT11Registrar' 2> $null | Measure-Object | %{$_.Count})
$unique3 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" 2> $null | select-string 'DisableFlashConfigRegistrar' 2> $null |  Measure-Object | %{$_.Count})
$unique4 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" 2> $null | select-string 'DisableWPDRegistrar' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( [int]$unique -eq '1' ) -And ( [int]$unique1 -eq '1' ) -And ( [int]$unique2 -eq '1' ) -And ( [int]$unique3 -eq '1' ) -And ( [int]$unique4 -eq '1' )) {
foreach ( $unique4 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" | select-string 'EnableRegistrars').ToString().Split('')[12].Trim() ) {
	foreach ( $unique5 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" | select-string 'DisableUPnPRegistrar').ToString().Split('')[12].Trim() ) {
		foreach ( $unique6 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" | select-string 'DisableInBand802DOT11Registrar').ToString().Split('')[12].Trim() ) {
			foreach ( $unique7 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" | select-string 'DisableFlashConfigRegistrar').ToString().Split('')[12].Trim() ) {
				foreach ( $unique8 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" 2> $null | select-string 'DisableWPDRegistrar').ToString().Split('')[12].Trim() ) {
				if (( [int]$unique4 -eq [int]'0x0' ) -And ( [int]$unique5 -eq [int]'0x0' ) -And ( [int]$unique6 -eq [int]'0x0' ) -And ( [int]$unique7 -eq [int]'0x0' ) -And ( [int]$unique8 -eq [int]'0x0' )) {
					Write-Output $unique4,$unique5,$unique6,$unique7,$unique8
				} else {
					Write-Output $unique4,$unique5,$unique6,$unique7,$unique8
					}
				}
			}
		}
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
