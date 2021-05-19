#   1.2.3 (L1) - Ensure 'Reset account lockout counter after' is set to '15 or more minute(s)' (Scored)
	$output = '15'
	$output1 = 'Never'
	$unique = (net accounts | select-string 'observation').ToString().Split(':')[1].Trim()
	if ($output1 -eq $unique) {
		Write-Output "failed $output1"
	} elseif ([int]$unique -lt [int]$output){
	          Write-Output "failed $unique"
	} else {
		Write-Output $unique
	}