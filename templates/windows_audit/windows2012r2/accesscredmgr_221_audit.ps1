#   2.2.1 (L1) Ensure 'Access Credential Manager as a trusted caller' is set to 'No One' (Scored)

	secedit /export /cfg c:\secpol.cfg > $null
	$output = (Get-content c:\secpol.cfg | select-string SeTrustedCredManAccessPrivilege) |  Measure-Object | %{$_.Count}
	if ($output -eq "1") {
			write-output "FAILED"
	} else {
			write-output "PASSED"
	}
	rm -force c:\secpol.cfg -confirm:$false 







