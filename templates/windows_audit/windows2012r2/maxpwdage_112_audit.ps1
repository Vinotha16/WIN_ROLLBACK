#   1.1.2 (L1) - Ensure 'Maximum password age' is set to '60 or fewer days, but not 0' (Scored)

	$output = '60'
	$output1 = 'Unlimited'
	$unique = (net accounts | select-string Maximum).ToString().Split(':')[1].Trim()
	if ($output1 -eq $unique) {
    Write-Output "FAILED"
	} elseif ([int]$output -lt [int]$unique){
    Write-Output "FAILED"
	} else {
		Write-Output "PASSED"
	}