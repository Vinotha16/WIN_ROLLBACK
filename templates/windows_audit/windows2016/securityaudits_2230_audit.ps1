#    2.2.30 (L1) - Ensure 'Generate security audits' is set to 'LOCAL SERVICE, NETWORK SERVICE'

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-19,*S-1-5-20'
$output = (Get-content c:\secpol.cfg | select-string 'SeAuditPrivilege').ToString().Split('=')[1].Trim()
if ($unique -ne $output) { 
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false

