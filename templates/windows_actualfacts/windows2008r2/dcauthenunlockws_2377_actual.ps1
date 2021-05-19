#   2.3.7.7 (L1) - Ensure 'Interactive logon: Require Domain Controller Authentication to unlock workstation' is set to 'Enabled' (MS only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,1'
$output = (Get-content c:\secpol.cfg | select-string 'ForceUnlockLogon').ToString().Split('=')[1].Trim()
$failed = (Get-content c:\secpol.cfg | select-string 'ForceUnlockLogon').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {
	write-output "failed $failed"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false 

