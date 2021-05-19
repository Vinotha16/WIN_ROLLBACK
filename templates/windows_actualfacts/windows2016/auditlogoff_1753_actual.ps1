# 17.5.3 (L1) Ensure 'Audit Logoff' is set to include 'Success' (Scored) 
$failed = (auditpol /get /category:*   | select-string " Logoff "  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Logoff ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique =  auditpol.exe /get /category:*   | select-string " Logoff "   | Foreach {"$(($_ -split '\s+',3)[2])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
    } else {
        write-output $unique
    }
