#   2.3.1.3 (L1) - Ensure 'Accounts: Guest account status' is set to 'Disabled' (MS only) (Scored)

$output = 'No'
$name=(Get-LocalUser | ForEach-Object {$_.Name + " " + $_.Description} | Select-String "Built-in account for guest access to the computer/domain" | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace('Built-in account for guest access to the computer/domain', '')})
$unique=(invoke-expression "net user $name" |select-string 'Account active').ToString().Split(' ')[16].Trim()
if ($output -ne $unique) {
        Write-Output "FAILED"
} else {
        Write-Output "PASSED"
}

