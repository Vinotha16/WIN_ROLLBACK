#   2.2.3 (L1) Ensure 'Access this computer from the network' is set to 'Administrators, Authenticated Users' (MS only) (Scored)

	secedit /export /cfg c:\secpol.cfg > $null
	$unique = '*S-1-5-11,*S-1-5-32-544'
	$output = (Get-content c:/secpol.cfg | select-string 'SeNetworkLogonRight').ToString().Split('=')[1].Trim()
	if ($unique -ne $output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}
	rm -force c:\secpol.cfg -confirm:$false 