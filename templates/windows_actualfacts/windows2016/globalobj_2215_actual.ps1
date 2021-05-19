#  2.2.15 (L1) - Ensure 'Create global objects' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-19,*S-1-5-20,*S-1-5-32-544,*S-1-5-6'
$output = (Get-content c:\secpol.cfg | select-string 'SeCreateGlobalPrivilege').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {    
  $failed = (Get-content c:\secpol.cfg | select-string 'SeCreateGlobalPrivilege').ToString().Split('=')[1].Trim().replace('*', '')
  write-output "failed $failed"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false