#   2.3.9.2 (L1) - Ensure 'Microsoft network server: Digitally sign communications (always)' is set to 'Enabled' (Scored)

secedit /export /cfg c:\secpol.cfg > $null 
$unique = '4,0'
$output = (Get-content c:\secpol.cfg | select-string 'LanManServer.*RequireSecuritySignature').ToString().Split('=')[1].Trim()

if ($unique -eq $output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false 

