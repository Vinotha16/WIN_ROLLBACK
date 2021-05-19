# 1.1.5 (L1) - Ensure 'Password must meet complexity requirements' is set to 'Enabled' (Scored)

	secedit /export /cfg c:\secpol.cfg > $null
	$unique = '1'
	$output = (Get-content c:\secpol.cfg | select-string PasswordComplexity).ToString().Split('=')[1].Trim()
	if ($unique -ne $output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}
	rm -force c:\secpol.cfg -confirm:$false