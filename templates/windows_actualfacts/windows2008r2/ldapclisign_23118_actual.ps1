#   2.3.11.8 (L1) - Ensure 'Network security: LDAP client signing requirements' is set to 'Negotiate signing' or higher (Scored)

secedit /export /cfg c:\secpol.cfg > $null 
$unique = '4,0'
$output = (Get-content c:\secpol.cfg | Select-String 'LDAPClientIntegrity').ToString().Split('=')[1].Trim()

if ($unique -eq $output) {
	write-output "failed $output"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false

