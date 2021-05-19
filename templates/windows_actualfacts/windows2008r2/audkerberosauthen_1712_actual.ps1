#17.1.2 (L1) Ensure 'Audit Kerberos Authentication Service' is set to 'Success and Failure' (DC Only) (Scored) 

$failed = (auditpol /get /category:*   | select-string "Kerberos Authentication Service"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Kerberos Authentication Service ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique = auditpol.exe /get /category:*   | select-string "Kerberos Authentication Service" | Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
    } else {
	    $unique = $unique -replace 'Success and Failure','success, failure'
        write-output $unique
    } 

