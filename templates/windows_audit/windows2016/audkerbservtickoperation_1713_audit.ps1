#17.1.3 (L1) Ensure 'Audit Kerberos Service Ticket Operations' is set to 'Success and Failure' (DC Only) (Scored)
$unique = (auditpol.exe /get /category:*   | select-string "Kerberos Service Ticket Operations" | Foreach {"$(($_ -split '\s+',6)[5])"})
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
        write-output "FAILED"
} else {
        write-output "PASSED"
	}
