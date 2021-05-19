#   2.3.10.1 (L1) Ensure 'Network access: Allow anonymous SID/Name translation' is set to 'Disabled' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '0'
$output = (Get-content c:\secpol.cfg | select-string 'LSAAnonymousNameLookup').ToString().Split('=')[1].Trim()
$failed = (Get-content c:\secpol.cfg | select-string 'LSAAnonymousNameLookup')
if ($unique -ne $output) {    $failed = $failed -replace 'LSAAnonymousNameLookup = ',''    write-output "failed $failed"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false

