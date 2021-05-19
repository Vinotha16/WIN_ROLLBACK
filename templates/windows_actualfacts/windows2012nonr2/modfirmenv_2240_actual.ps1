#   2.2.40 (L1) - Ensure 'Modify firmware environment values' is set to 'Administrators' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-32-544'
$output = (Get-content c:\secpol.cfg | select-string 'SeSystemEnvironmentPrivilege').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {   
        $failed = (Get-content c:\secpol.cfg | select-string 'SeSystemEnvironmentPrivilege').ToString().Split('=')[1].Trim().replace('*', '')
        write-output "failed $failed"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false