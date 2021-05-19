#   2.3.10.5 (L1) - Ensure 'Network access: Let Everyone permissions apply to anonymous users' is set to 'Disabled' (Scored)
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,0'
$output = (Get-content c:\secpol.cfg | Select-String 'EveryoneIncludesAnonymous').ToString().Split('=')[1].Trim()

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
