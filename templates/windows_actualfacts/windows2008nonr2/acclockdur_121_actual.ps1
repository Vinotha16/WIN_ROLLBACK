#   1.2.1 (L1) - Ensure 'Account lockout duration' is set to '15 or more minute(s)' (Scored)
	$output = '15'
	$output1 = 'Never'
	$unique = (net accounts | select-string 'Lockout duration').ToString().Split(':')[1].Trim()
	if ($output1 -eq $unique) {
		Write-Output "failed $output1"
	} elseif ([int]$unique -lt [int]$output){
	          Write-Output "failed $unique"
	} else {
		Write-Output $unique
	}