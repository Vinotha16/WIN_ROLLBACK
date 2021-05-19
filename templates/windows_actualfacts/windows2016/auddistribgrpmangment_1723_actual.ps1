# 17.2.3 (L1) Ensure 'Audit Distribution Group Management' is set to include 'Success' (DC only) (Scored) 
$failed = (auditpol /get /category:*   | select-string "Distribution Group Management"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Distribution Group Management ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique = auditpol.exe /get /category:*   | select-string "Distribution Group Management" | Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
    } else {
        write-output $unique
    }
