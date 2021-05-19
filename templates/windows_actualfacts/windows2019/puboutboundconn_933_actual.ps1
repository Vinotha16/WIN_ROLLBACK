#  	9.3.3 (L1) - Ensure 'Windows Firewall: Public: Outbound connections' is set to 'Allow (default)' (Scored)
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile")	
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" 2> $null | select-string 'DefaultOutboundAction' 2> $null |  Measure-Object | %{$_.Count})
	
if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile" | select-string 'DefaultOutboundAction').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x0' ) {
		Write-Output $unique1
	} else {
	     Write-Output ""
		}
	}
}else {
    Write-Output ""
   }
}
Catch [System.Management.Automation.ItemNotFoundException]
{
 Write-Output ""
 }
Finally { $ErrorActionPreference = "Continue" }
