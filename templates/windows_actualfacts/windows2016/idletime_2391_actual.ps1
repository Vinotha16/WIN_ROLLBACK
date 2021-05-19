#   2.3.9.1 (L1) Ensure 'Microsoft network server: Amount of idle time required before suspending session' is set to '15 or fewer minute(s)' (Scored)
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\System\Currentcontrolset\Services\Lanmanserver\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
	secedit /export /cfg c:\secpol.cfg > $null
	$unique = '4,15'
	$output = (Get-content c:\secpol.cfg | select-string AutoDisconnect).ToString().Split('=')[1].Trim()
	if ($output -eq '4,4294967295') {
		write-output ""
	} elseif ([int]$unique -lt [int]$output) {
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
