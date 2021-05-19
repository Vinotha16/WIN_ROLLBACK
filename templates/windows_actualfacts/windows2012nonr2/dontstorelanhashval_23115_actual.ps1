#   2.3.11.5 (L1) - Ensure 'Network security: Do not store LAN Manager hash value on next password change' is set to 'Enabled' (Scored)

secedit /export /cfg c:\secpol.cfg > $null 
$unique = '4,1'
$output = (Get-content c:\secpol.cfg | Select-String 'NoLMHash').ToString().Split('=')[1].Trim()

if ($unique -ne $output) {
	write-output "failed $output"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false

