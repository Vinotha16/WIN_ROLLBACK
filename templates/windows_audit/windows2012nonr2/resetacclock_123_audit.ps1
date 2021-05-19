#   1.2.3 (L1) - Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)' (Scored)

	$output = '15'
	$unique = (net accounts | select-string 'observation').ToString().Split(':')[1].Trim()
	if ([int]$output -gt [int]$unique) {
		Write-Output "FAILED"
	} else {
		Write-Output "PASSED"
	}