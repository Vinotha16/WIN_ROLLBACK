
#   1.1.1 (L1) - Ensure 'Enforce password history' is set to '24 or more password(s)' (Scored)

$output = '24'
$output1 = 'None'
$unique = (net accounts | select-string 'Length of password history maintained:').ToString().Split(':')[1].Trim()
    if ($unique -eq $output1) {
        $output1 = $output1 | ForEach-Object {$_.replace('None', '0')}
        Write-Output "failed $output1"
    } elseif ([int]$output -gt [int]$unique) {
        $output = (net accounts | select-string 'Length of password history maintained: ' | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace('Length of password history maintained: ', '')})
        Write-Output "failed $output"
    } else {
        Write-Output $unique
    }