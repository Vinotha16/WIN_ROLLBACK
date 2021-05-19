#  	18.9.102.1.2 (L1) Ensure 'Select when Preview Builds and Feature Updates are received' is set to 'Enabled: Semi-Annual Channel, 180 or more days' (Scored)
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'  -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" 2> $null | select-string 'DeferFeatureUpdates  ' 2> $null |  Measure-Object | %{$_.Count})
$unique1 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" 2> $null | select-string 'DeferFeatureUpdatesPeriodInDays' 2> $null |  Measure-Object | %{$_.Count})
$unique2 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" 2> $null | select-string 'BranchReadinessLevel' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' ) -And ( $unique1 -eq '1' ) ) {
	foreach ( $unique3 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | select-string 'DeferFeatureUpdates  ').ToString().Split('')[12].Trim() ) {
		foreach ( $unique4 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | select-string 'DeferFeatureUpdatesPeriodInDays').ToString().Split('')[12].Trim() ) {
			foreach ( $unique5 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | select-string 'BranchReadinessLevel').ToString().Split('')[12].Trim() ) {
			if ( ( [int]$unique3 -eq [int]'0x1' ) -And ( [int]$unique4 -eq [int]'0xb4' )  -And ( [int]$unique5 -eq [int]'0x14' ) ) {
				Write-Output "PASSED"
			} else {
				Write-Output "FAILED"
				}
			}
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