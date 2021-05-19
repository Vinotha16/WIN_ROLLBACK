#  17.9.5 (L1) Ensure 'Audit System Integrity' is set to 'Success and Failure' (Scored)

$unique = auditpol.exe /get /category:*   | select-string "System Integrity" |  Foreach {"$(($_ -split '\s+',4)[3])"}
$output = "Success and Failure"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
