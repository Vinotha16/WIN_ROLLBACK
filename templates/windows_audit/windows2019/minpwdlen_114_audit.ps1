
#   1.1.4 (L1) - Ensure 'Minimum password length' is set to '14 or more character(s)' (Scored)

	$output = '14'
	$unique = (net accounts | select-string 'Minimum password length').ToString().Split(':')[1].Trim()
	if ([int]$output -gt [int]$unique) {
		Write-Output "FAILED"
	} else {
		Write-Output "PASSED"
	}