#   2.3.11.6 (L1) - Ensure 'Network security: Force logoff when logon hours expire' is set to 'Enabled' (Not Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '1'
$output = (Get-content c:\secpol.cfg | Select-String 'ForceLogoffWhenHourExpire').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false

