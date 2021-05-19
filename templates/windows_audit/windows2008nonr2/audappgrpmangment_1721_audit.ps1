# 17.2.1 - (L1) Ensure 'Audit Application Group Management' is set to 'Success and Failure' (Scored)

$unique = (auditpol.exe /get /category:*   | select-string "Application Group Management" | Foreach {"$(($_ -split '\s+',5)[4])"})
$output = "Success and Failure"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
	