 # 17.6.1 (L1) Ensure 'Audit Detailed File Share' is set to include 'Failure' (Scored) 
 
$unique = auditpol.exe /get /category:*   | select-string "Detailed File Share" | Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Failure"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
} 


