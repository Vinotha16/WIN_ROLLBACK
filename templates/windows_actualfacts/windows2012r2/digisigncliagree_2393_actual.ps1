#   2.3.9.3 (L1) - Ensure 'Microsoft network server: Digitally sign communications (if client agrees)' is set to 'Enabled' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,0'
$output = (Get-content c:\secpol.cfg | select-string LanManServer.*EnableSecuritySignature).ToString().Split('=')[1].Trim()

if ($unique -eq $output) {
	write-output "failed $output"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false 

