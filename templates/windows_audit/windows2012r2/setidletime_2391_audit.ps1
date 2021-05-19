
#   2.3.9.1 (L1) Ensure 'Microsoft network server: Amount of idle time required before suspending session' is set to '15 or fewer minute(s)' (Scored)

	secedit /export /cfg c:\secpol.cfg > $null
	$unique = '4,15'
	$output = (Get-content c:\secpol.cfg | select-string AutoDisconnect).ToString().Split('=')[1].Trim()
	if ($output -ne '4,15') {
		write-output "FAILED"
	} elseif ([int]$unique -lt [int]$output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}
	rm -force c:\secpol.cfg -confirm:$false 
