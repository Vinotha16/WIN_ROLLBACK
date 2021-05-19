#   2.3.1.1 (L1) - Ensure 'Accounts: Administrator account status' is set to 'Disabled' (MS only) (Scored)

$output = 'No'
$unique = (net user administrator  | select-string 'Account active').ToString().Split(' ')[16].Trim()
if ($output -ne $unique) {
   Write-Output "FAILED"
} else {
	Write-Output "PASSED"
}

