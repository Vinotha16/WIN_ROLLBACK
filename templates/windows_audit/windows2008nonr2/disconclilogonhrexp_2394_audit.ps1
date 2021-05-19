#   2.3.9.4 (L1) - Ensure 'Microsoft network server: Disconnect clients when logon hours expire' is set to 'Enabled' (Scored)


secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,1'
$output = (Get-content c:\secpol.cfg | select-string 'EnableForcedLogOff').ToString().Split('=')[1].Trim()

if ($unique -ne $output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false 

