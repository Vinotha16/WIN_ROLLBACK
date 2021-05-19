#   2.2.9 (L1) - Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users' (MS only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-32-544,*S-1-5-32-555'
$output = (Get-content c:\secpol.cfg | select-string 'SeRemoteInteractiveLogonRight ').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {
   $failed = (Get-content c:\secpol.cfg | select-string 'SeRemoteInteractiveLogonRight ').ToString().Split('=')[1].Trim().replace('*', '')
   write-output "failed $failed"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false