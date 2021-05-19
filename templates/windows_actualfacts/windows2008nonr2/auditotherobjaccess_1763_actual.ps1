# 17.6.3 (L1) Ensure 'Audit Other Object Access Events' is set to 'Success and Failure' (Scored) 
$failed = (auditpol /get /category:*   | select-string "Other Object Access Events"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Other Object Access Events ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique =  auditpol.exe /get /category:*   | select-string "Other Object Access Events" |  Foreach {"$(($_ -split '\s+',6)[5])"}
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
    } else {
        $unique = $unique -replace 'Success and Failure','success, failure'
        write-output $unique
    }

