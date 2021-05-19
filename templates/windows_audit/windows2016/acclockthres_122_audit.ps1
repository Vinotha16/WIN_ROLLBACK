	
#  1.2.2 (L1) - Ensure 'Account lockout threshold' is set to '10 or fewer invalid logon attempt(s), but not 0' (Scored)

	$output = '10'
	$output1 = 'Never'
	$unique = (net accounts | select-string 'Lockout threshold').ToString().Split(':')[1].Trim()
	if ($output1 -eq $unique) {
	Write-Output "FAILED"
	} elseif ([int]$output -lt [int]$unique) {
	Write-Output "FAILED"
	} else {
		Write-Output "PASSED"
	}
