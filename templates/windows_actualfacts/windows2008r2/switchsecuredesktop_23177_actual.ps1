#   2.3.17.7 (L1) - Ensure 'User Account Control: Switch to the secure desktop when prompting for elevation' is set to 'Enabled' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,1'
$output = (Get-content c:\secpol.cfg | Select-String 'PromptOnSecureDesktop').ToString().Split('=')[1].Trim()

if ($unique -ne $output) {
	write-output ""
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false

