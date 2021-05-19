#2.3.1.1 (L1) - Ensure 'Accounts: Administrator account status' is set to 'Disabled' (MS only) (Scored)
$output = 'No'
$name=(Get-LocalUser | ForEach-Object {$_.Name + " " + $_.Description} | Select-String "Built-in account for administering the computer/domain" | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace('Built-in account for administering the computer/domain', '')})
$unique=(invoke-expression "net user $name" |select-string 'Account active').ToString().Split(' ')[16].Trim()
if ($output -ne $unique) {
    $unique = $unique -replace 'Yes','1'
        Write-Output "failed $unique"
} else {
        Write-Output $output
}
