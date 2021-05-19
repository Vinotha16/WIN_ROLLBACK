#  17.5.5 (L1) Ensure 'Audit Special Logon' is set to include 'Success' (Scored)
$failed = (auditpol /get /category:*   | select-string "Special Logon"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Special Logon ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique = auditpol.exe /get /category:*   | select-string "Special Logon" |  Foreach {"$(($_ -split '\s+',4)[3])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
    } else {
        write-output $unique
    }

