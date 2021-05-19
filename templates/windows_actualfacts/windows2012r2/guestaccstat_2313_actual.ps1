#   2.3.1.3 (L1) - Ensure 'Accounts: Guest account status' is set to 'Disabled' (MS only) (Scored)

$output = 'No'
$unique = (net user guest | select-string 'Account active').ToString().Split(' ')[16].Trim()
if ($output -ne $unique) {
    $output = (net user guest | select-string 'Account active' | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace('Account active ', '')})
    $output = $output -replace 'Yes','1'
    Write-Output "failed $output"
} else {
	Write-Output $unique
}

