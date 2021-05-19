# 17.5.1 (L1) Ensure 'Audit Account Lockout' is set to include 'Failure' (Scored) 

$unique = auditpol.exe /get /category:*   | select-string "Account Lockout" |  Foreach {"$(($_ -split '\s+',4)[3])"}
$output = "Failure"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
