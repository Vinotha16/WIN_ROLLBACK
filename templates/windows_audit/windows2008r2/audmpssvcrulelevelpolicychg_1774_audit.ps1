 # 17.7.4 (L1) Ensure 'Audit MPSSVC Rule-Level Policy Change' is set to 'Success and Failure' (Scored) 
 
$unique = auditpol.exe /get /category:*   | select-string "MPSSVC Rule-Level Policy Change" | Foreach {"$(($_ -split '\s+',6)[5])"}
$output = "Success and Failure"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}