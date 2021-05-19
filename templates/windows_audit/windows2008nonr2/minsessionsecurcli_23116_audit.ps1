#   2.3.11.6 (L1) - Ensure 'Network security: Minimum session security for NTLM SSP based (including secure RPC) clients' is set to 'Require NTLMv2 session security, Require 128-bit encryption' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,537395200'
$output = (Get-content c:\secpol.cfg | Select-String 'NTLMMinClientS').ToString().Split('=')[1].Trim()

if ($unique -eq $output) {
	write-output "FAILED"
	} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false

