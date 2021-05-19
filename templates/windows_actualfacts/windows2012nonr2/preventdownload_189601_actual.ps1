#  	18.9.59.1 (L1) - Ensure 'Prevent downloading of enclosures' is set to 'Enabled' 

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

 $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds" 2> $null | select-string 'DisableEnclosureDownload' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds" | select-string 'DisableEnclosureDownload').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x1' ) {
		Write-Output $unique1
	} else {
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