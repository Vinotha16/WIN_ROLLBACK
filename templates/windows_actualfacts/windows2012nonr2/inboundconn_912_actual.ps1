#  	9.1.2 (L1) - Ensure 'Windows Firewall: Domain: Inbound connections' is set to 'Block (default)'
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile" 2> $null | select-string 'DefaultInboundAction' 2> $null |  Measure-Object | %{$_.Count})
	
if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile" | select-string 'DefaultInboundAction').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x1' ) {
		Write-Output $unique1
	} else {
		Write-Output ""
		}
	}
}else{ 
	Write-Output ""
     }	
	
}
Catch [System.Management.Automation.ItemNotFoundException]
{
 Write-Output ""
 }
Finally { $ErrorActionPreference = "Continue" }


