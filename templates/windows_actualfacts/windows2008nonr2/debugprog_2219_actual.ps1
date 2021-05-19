#   2.2.19 (L1) - Ensure 'Debug programs' is set to 'Administrators' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-32-544'
$output = (Get-content c:\secpol.cfg | select-string 'SeDebugPrivilege').ToString().Split('=')[1].Trim()
$failed = (Get-content c:\secpol.cfg | select-string 'SeDebugPrivilege').ToString().Split('=')[1].Trim().replace('*', '')
if ($unique -ne $output) {    
       write-output "failed $failed"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false
