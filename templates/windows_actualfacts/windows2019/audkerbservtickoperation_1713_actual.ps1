#17.1.3 (L1) Ensure 'Audit Kerberos Service Ticket Operations' is set to 'Success and Failure' (DC Only) (Scored)
$failed = (auditpol /get /category:*   | select-string "Kerberos Service Ticket Operations"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Kerberos Service Ticket Operations ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique = (auditpol.exe /get /category:*   | select-string "Kerberos Service Ticket Operations" | Foreach {"$(($_ -split '\s+',6)[5])"})
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
   } else {
        $unique = $unique -replace 'Success and Failure','success, failure'
        write-output $unique
	}
