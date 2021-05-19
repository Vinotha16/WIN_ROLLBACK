
#   1.1.4 (L1) - Ensure 'Minimum password length' is set to '14 or more character(s)' (Scored)

	$output = '14'
	$unique = (net accounts | select-string 'Minimum password length').ToString().Split(':')[1].Trim()
	if ([int]$output -gt [int]$unique) {
	    $output = (net accounts | select-string 'Minimum password length: ' | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace('Minimum password length: ', '')})
	    Write-Output "failed $output"
	} else {
		Write-Output $unique
	}