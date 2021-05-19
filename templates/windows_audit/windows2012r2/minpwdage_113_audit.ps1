#   1.1.3 (L1) - Ensure 'Minimum password age' is set to '1 or more day(s)' (Scored)

	$output = '1'
	$unique = (net accounts | select-string 'Minimum password age').ToString().Split(':')[1].Trim()
	if ([int]$output -gt [int]$unique) {
    Write-Output "FAILED"
	} else {
		Write-Output "PASSED"
	}