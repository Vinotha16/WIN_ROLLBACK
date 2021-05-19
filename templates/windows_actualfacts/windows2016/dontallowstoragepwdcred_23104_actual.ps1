#   2.3.10.4 (L2) - Ensure 'Network access: Do not allow storage of passwords and credentials for network authentication' is set to 'Enabled' (Scored)
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,0'
$output = (Get-content c:\secpol.cfg | Select-String 'DisableDomainCreds').ToString().Split('=')[1].Trim()

if ($unique -eq $output) {
	write-output "failed $output"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false
}
Catch [System.Management.Automation.ItemNotFoundException]
{
 Write-Output ""
 }
Finally { $ErrorActionPreference = "Continue" }
