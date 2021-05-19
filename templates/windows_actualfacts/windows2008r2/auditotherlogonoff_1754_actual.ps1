# 17.5.4 (L1) Ensure 'Audit Other Logon/Logoff Events' is set to 'Success and Failure' (Scored)
$failed = (auditpol /get /category:*   | select-string "Other Logon/Logoff Events"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Other Logon/Logoff Events ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique =  auditpol.exe /get /category:*   | select-string "Other Logon/Logoff Events" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
    } else {
        $unique = $unique -replace 'Success and Failure','success, failure'
        write-output $unique
    }