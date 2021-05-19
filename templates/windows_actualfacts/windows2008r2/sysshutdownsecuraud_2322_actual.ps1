#   2.3.2.2 (L1) - Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Disabled' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,0'
$output = (Get-content c:/secpol.cfg | select-string 'CrashOnAuditFail').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {
	write-output ""
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false 

