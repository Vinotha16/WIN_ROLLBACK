#  17.8.1 (L1) Ensure 'Audit Sensitive Privilege Use' is set to 'Success and Failure' (Scored)
$data = "Sensitive Privilege Use"
$failed = (auditpol /get /category:*  | select-string "  Sensitive Privilege Use" | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Sensitive Privilege Use ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique = auditpol.exe /get /category:*  | select-string "  Sensitive Privilege Use"  |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
    } else {
        $unique = $unique -replace 'Success and Failure','success, failure'
        write-output $unique
    }
