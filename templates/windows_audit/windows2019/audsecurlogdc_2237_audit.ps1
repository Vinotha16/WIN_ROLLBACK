#  2.2.37 (L1) - Ensure 'Manage auditing and security log' is set to 'Administrators` and (when Exchange is running in the environment) `Exchange Servers' (DC only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-32-544'
$output = (Get-content c:\secpol.cfg | select-string 'SeSecurityPrivilege').ToString().Split('=')[1].Trim()

if ($unique -ne $output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false

