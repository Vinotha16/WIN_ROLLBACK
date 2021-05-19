#   1.1.3 (L1) - Ensure 'Minimum password age' is set to '1 or more day(s)' (Scored)

	$output = '1'
	$unique = (net accounts | select-string 'Minimum password age').ToString().Split(':')[1].Trim()
	if ([int]$output -gt [int]$unique) {
	    $output = (net accounts | select-string 'Minimum password age ' | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace('Minimum password age (days): ', '')})
	    Write-Output "failed $output"
	} else {
		Write-Output $unique
	}