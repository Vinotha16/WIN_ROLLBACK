#   2.2.46 (L1) - Ensure 'Shut down the system' is set to 'Administrators' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-32-544'
$output = (Get-content c:\secpol.cfg | select-string 'SeShutdownPrivilege').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false

