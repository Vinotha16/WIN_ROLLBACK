# 17.6.1 (L1) Ensure 'Audit Detailed File Share' is set to include 'Failure' (Scored)
$failed = (auditpol /get /category:*   | select-string "Detailed File Share"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Detailed File Share ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique = (auditpol.exe /get /category:*   | select-string "Detailed File Share" | Foreach {"$(($_ -split '\s+',5)[4])"})
$output = "Failure"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
} else {
        write-output $unique
}