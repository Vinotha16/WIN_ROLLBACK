#  2.2.11 (L1) - Ensure 'Change the system time' is set to 'Administrators, LOCAL SERVICE' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-19,*S-1-5-32-544'
$output = (Get-content c:\secpol.cfg | select-string 'SeSystemtimePrivilege').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {
   $failed = (Get-content c:\secpol.cfg | select-string 'SeSystemtimePrivilege').ToString().Split('=')[1].Trim().replace('*', '')
   write-output "failed $failed"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false