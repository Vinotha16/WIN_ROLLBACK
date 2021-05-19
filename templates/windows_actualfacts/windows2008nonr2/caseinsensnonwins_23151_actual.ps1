#   2.3.15.1 (L1) - Ensure 'System objects: Require case insensitivity for nonWindows subsystems' is set to 'Enabled' (Scored)

secedit /export /cfg c:\secpol.cfg > $null 
$unique = '4,1'
$output = (Get-content c:\secpol.cfg | Select-String 'ObCaseInsensitive').ToString().Split('=')[1].Trim()

if ($unique -ne $output) {
	write-output "failed $output"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false

