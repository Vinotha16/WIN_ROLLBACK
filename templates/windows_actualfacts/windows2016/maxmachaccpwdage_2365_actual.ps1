#   2.3.6.5 (L1) - Ensure 'Domain member: Maximum machine account password age' is set to '30 or fewer days, but not 0' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,30'
$output = (Get-content c:\secpol.cfg | select-string MaximumPasswordAge=).ToString().Split('=')[1].Trim()
if ($output -eq '4,0') {
	write-output ""
} elseif ([int]$unique -lt [int]$output){
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
