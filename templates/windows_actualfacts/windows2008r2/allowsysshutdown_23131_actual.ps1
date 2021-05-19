#   2.3.13.1 (L1) - Ensure 'Shutdown: Allow system to be shut down without having to log on' is set to 'Disabled' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,0'
$output = (Get-content c:\secpol.cfg | Select-String 'ShutdownWithoutLogon').ToString().Split('=')[1].Trim()

if ($unique -ne $output) {
	write-output "failed $output"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false

