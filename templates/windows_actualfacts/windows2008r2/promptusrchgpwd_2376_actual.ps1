#   2.3.7.6 (L1) - Ensure 'Interactive logon: Prompt user to change password before expiration' is set to 'between 5 and 14 days' (Scored)

secedit /export /cfg c:\secpol.cfg > $null 
$unique = '4,5'
$output = (Get-content c:\secpol.cfg | select-string PasswordExpiryWarning).ToString().Split('=')[1].Trim()
if ([int]$unique -gt [int]$output) {
$failed1 = (Get-content c:\secpol.cfg | select-string PasswordExpiryWarning).ToString().Split('=')[1].Trim() | ForEach-Object {$_.replace('4,', '')}
	write-output "failed $failed1"
} elseif ([int]$output -gt '4,14') {
$failed2 = (Get-content c:\secpol.cfg | select-string PasswordExpiryWarning).ToString().Split('=')[1].Trim() | ForEach-Object {$_.replace('4,', '')}
	write-output "failed $failed2"
} else {
$output1 = (Get-content c:\secpol.cfg | select-string PasswordExpiryWarning).ToString().Split('=')[1].Trim() | ForEach-Object {$_.replace('4,', '')}
	write-output $output1
}
rm -force c:\secpol.cfg -confirm:$false