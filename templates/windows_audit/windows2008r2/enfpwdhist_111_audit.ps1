#   1.1.1 (L1) - Ensure 'Enforce password history' is set to '24 or more password(s)' (Scored)

	$output = '24'
	$output1 = 'None'
	$unique = (net accounts | select-string 'Length of password history maintained:').ToString().Split(':')[1].Trim()
	if ($unique -eq $output1) {
   Write-Output "FAILED"
	} elseif ([int]$output -gt [int]$unique) {
   Write-Output "FAILED"
	} else {
		Write-Output "PASSED"
	}