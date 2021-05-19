#  17.7.2 (L1) Ensure 'Audit Authentication Policy Change' is set to 'Success' (Scored)
$failed = (auditpol /get /category:*   | select-string "Authentication Policy Change"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Authentication Policy Change ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique =  auditpol.exe /get /category:*   | select-string "Authentication Policy Change" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
    } else {
        write-output $unique
    }
