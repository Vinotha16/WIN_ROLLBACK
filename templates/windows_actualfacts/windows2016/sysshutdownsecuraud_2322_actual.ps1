#   2.3.2.2 (L1) - Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Disabled' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\System\Currentcontrolset\Control\Lsa' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,0'
$output = (Get-content c:/secpol.cfg | select-string 'CrashOnAuditFail').ToString().Split('=')[1].Trim()
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
