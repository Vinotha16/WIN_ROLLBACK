#  17.8.1 (L1) Ensure 'Audit Sensitive Privilege Use' is set to 'Success and Failure' (Scored)

$unique = auditpol.exe /get /category:*   | select-string "Sensitive Privilege Use"  |  Foreach {"$(($_ -split '\s+',4)[3])"}
$output = "Success and Failure"

if ([string]$unique -eq [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
