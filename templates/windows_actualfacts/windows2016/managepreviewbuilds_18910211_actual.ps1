#  	18.9.102.1.1 (L1) - Ensure 'Manage preview builds' is set to 'Enabled: Disable preview builds' 
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'  -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" 2> $null | select-string 'ManagePreviewBuilds ' 2> $null |  Measure-Object | %{$_.Count})
$unique1 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" 2> $null | select-string 'ManagePreviewBuildsPolicyValue' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' ) -And ( $unique1 -eq '1' ) ) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | select-string 'ManagePreviewBuilds ').ToString().Split('')[12].Trim() ) {
		foreach ( $unique2 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | select-string 'ManagePreviewBuildsPolicyValue').ToString().Split('')[12].Trim() ) {
		if ( ( [int]$unique1 -eq [int]'0x1' ) -And ( [int]$unique2 -eq [int]'0x0' ) ) {
			Write-Output $unique1,$unique2
		} else {
			 Write-Output $unique1,$unique2
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
