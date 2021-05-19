 #17.1.2 (L1) Ensure 'Audit Kerberos Authentication Service' is set to 'Success and Failure' (DC Only) (Scored) 
 
$unique = (auditpol.exe /get /category:*   | select-string "Kerberos Authentication Service" | Foreach {"$(($_ -split '\s+',5)[4])"})
$output = "Success and Failure"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
