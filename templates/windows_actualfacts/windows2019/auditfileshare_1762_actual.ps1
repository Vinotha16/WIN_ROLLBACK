# 17.6.2 (L1) Ensure 'Audit File Share' is set to 'Success and Failure' (Scored)
$failed = (auditpol /get /category:*   | select-string "  File Share"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' File Share ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique = auditpol.exe /get /category:*   | select-string "  File Share" | Foreach {"$(($_ -split '\s+',4)[3])"}
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
    } else {
        $unique = $unique -replace 'Success and Failure','success, failure'
        write-output $unique
    } 


