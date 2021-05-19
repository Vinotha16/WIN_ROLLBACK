#   2.2.21 (L1) - Ensure 'Deny access to this computer from the network' is set to 'Guests, Local account and member of Administrators group' (MS only) (Scored)

	secedit /export /cfg c:\secpol.cfg > $null
	$unique = '*S-1-5-114,*S-1-5-32-546'
	$output = (Get-content c:\secpol.cfg | select-string "SeDenyNetworkLogonRight") |  Measure-Object | %{$_.Count}
	if ($output -eq 1) {
		$output1 = (Get-content c:\secpol.cfg | select-string "SeDenyNetworkLogonRight").ToString().Split('=')[1].Trim() 2> $null	
			if ([string]$output1 -eq [string]$unique) {
					write-output "FAILED"
			
			} else {
					write-output "PASSED"
					}
	} else {
		write-output "FAILED"
	}
	rm -force c:\secpol.cfg -confirm:$false 