
#   1.1.2 (L1) - Ensure 'Maximum password age' is set to '60 or fewer days, but not 0' (Scored)

	$output = '60'
	$output1 = 'Unlimited'
	$unique = (net accounts | select-string Maximum).ToString().Split(':')[1].Trim()
	if ($output1 -eq $unique) {
	    $output1 = $output1 | ForEach-Object {$_.replace('Unlimited', '-1')}
		Write-Output "failed $output1"
	} elseif ([int]$output -lt [int]$unique){
	         $output = (net accounts | select-string 'Maximum password age (days): ' | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace('Maximum password age (days): ', '')})
	         Write-Output "failed $output"
	} else {
		Write-Output $unique
	}