#   2.2.10 (L1) - Ensure 'Back up files and directories' is set to 'Administrators' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-32-544'
$output = (Get-content c:\secpol.cfg | select-string 'SeBackupPrivilege').ToString().Split('=')[1].Trim()
if ($unique -ne $output) { 
        $failed = (Get-content c:\secpol.cfg | select-string 'SeBackupPrivilege').ToString().Split('=')[1].Trim().replace('*', '')
        write-output "failed $failed"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false