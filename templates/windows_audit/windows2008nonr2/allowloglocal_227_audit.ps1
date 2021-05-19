#   2.2.7 (L1) - Ensure 'Allow log on locally' is set to 'Administrators' (Scored)


	secedit /export /cfg c:\secpol.cfg > $null
	$unique = '*S-1-5-32-544'
	$output = (Get-content c:\secpol.cfg | select-string 'SeInteractiveLogonRight').ToString().Split('=')[1].Trim()
	if ($unique -eq $output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}
	rm -force c:\secpol.cfg -confirm:$false 