#   2.2.18 (L1) Ensure 'Create symbolic links' is set to 'Administrators, NT VIRTUAL MACHINE\Virtual Machines' (MS only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-32-544,*S-1-5-83-0'
$output = (Get-content c:\secpol.cfg | select-string 'SeCreateSymbolicLinkPrivilege').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {
    $failed = (Get-content c:\secpol.cfg | select-string 'SeCreateSymbolicLinkPrivilege').ToString().Split('=')[1].Trim().replace('*', '')
    write-output "failed $failed"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false