# 17.2.5 (L1) Ensure 'Audit Security Group Management' is set to include 'Success' (Scored)

$unique = auditpol.exe /get /category:*   | select-string "Security Group Management" | Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
