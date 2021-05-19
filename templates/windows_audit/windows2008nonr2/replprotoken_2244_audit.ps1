#   2.2.44 (L1) - Ensure 'Replace a process level token' is set to 'LOCAL SERVICE, NETWORK SERVICE' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-19,*S-1-5-20'
$output = (Get-content c:\secpol.cfg | select-string 'SeAssignPrimaryTokenPrivilege').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false

