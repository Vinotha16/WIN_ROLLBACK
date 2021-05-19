# 17.2.1 - (L1) Ensure 'Audit Application Group Management' is set to 'Success and Failure' (Scored)
$failed = (auditpol /get /category:*   | select-string "Application Group Management"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Application Group Management ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique = (auditpol.exe /get /category:*   | select-string "Application Group Management" | Foreach {"$(($_ -split '\s+',5)[4])"})
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
    } else {
        $unique = $unique -replace 'Success and Failure','success, failure'
        write-output $unique
    }