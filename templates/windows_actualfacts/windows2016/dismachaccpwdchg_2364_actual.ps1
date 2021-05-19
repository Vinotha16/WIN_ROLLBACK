#   2.3.6.4 (L1) - Ensure 'Domain member: Disable machine account password changes' is set to 'Disabled' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,0'
$output = (Get-content c:\secpol.cfg | select-string 'DisablePasswordChange').ToString().Split('=')[1].Trim()

if ($unique -ne $output) {
	write-output ""
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
