#   1.2.1 (L1) - Ensure 'Account lockout duration' is set to '15 or more minute(s)' (Scored)

	$output = '15'
	$output1 = 'Never'
	$unique = (net accounts | select-string 'Lockout duration').ToString().Split(':')[1].Trim()
	if ($output1 -eq $unique) {
		Write-Output "FAILED"
	} elseif ([int]$output -gt [int]$unique){
		Write-Output "FAILED"
	} else {
		Write-Output "PASSED"
	}