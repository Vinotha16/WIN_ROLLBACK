#   2.3.8.3 (L1) - Ensure 'Microsoft network client: Send unencrypted password to third-party SMB servers' is set to 'Disabled' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LanmanWorkstation\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,0'
$output = (Get-content c:\secpol.cfg | select-string 'EnablePlainTextPassword').ToString().Split('=')[1].Trim()

if ($unique -ne $output) {
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
