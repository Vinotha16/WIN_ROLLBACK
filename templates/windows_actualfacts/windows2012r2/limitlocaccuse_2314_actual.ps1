#   2.3.1.4 (L1) - Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set to 'Enabled' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,1'
$output = (Get-content c:\secpol.cfg | select-string 'LimitBlankPasswordUse').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {
	write-output ""
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false 

