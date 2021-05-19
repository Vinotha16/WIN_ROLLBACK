 # 17.6.2 (L1) Ensure 'Audit File Share' is set to 'Success and Failure' (Scored) 
 
$unique = auditpol.exe /get /category:*   | select-string "  File Share" | Foreach {"$(($_ -split '\s+',4)[3])"}
$output = "Success and Failure"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
} 
