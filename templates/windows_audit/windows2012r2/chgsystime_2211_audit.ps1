#  2.2.11 (L1) - Ensure 'Change the system time' is set to 'Administrators, LOCAL SERVICE' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-19,*S-1-5-32-544'
$output = (Get-content c:\secpol.cfg | select-string 'SeSystemtimePrivilege').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false
