#   2.2.43 (L1) - Ensure 'Profile system performance' is set to 'Administrators, NT SERVICE\WdiServiceHost' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-32-544,*S-1-5-80-3139157870-2983391045-3678747466-658725712-1809340420'
$output = (Get-content c:\secpol.cfg | select-string 'SeSystemProfilePrivilege').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false

