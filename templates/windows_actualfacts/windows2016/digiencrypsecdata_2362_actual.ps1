#   2.3.6.2 (L1) - Ensure 'Domain member: Digitally encrypt secure channel data (when possible)' is set to 'Enabled' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,1'
$output = (Get-content c:\secpol.cfg | select-string 'SealSecureChannel').ToString().Split('=')[1].Trim()

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
