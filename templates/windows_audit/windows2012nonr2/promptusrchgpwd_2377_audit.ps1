#   2.3.7.7 (L1) - Ensure 'Interactive logon: Prompt user to change password before expiration' is set to 'between 5 and 14 days' (Scored)

secedit /export /cfg c:\secpol.cfg > $null 
$unique = '4,5'
$output = (Get-content c:\secpol.cfg | select-string PasswordExpiryWarning).ToString().Split('=')[1].Trim()
if ([int]$unique -gt [int]$output) {
	write-output "FAILED"
} elseif ([int]$output -gt '4,14') {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false 

