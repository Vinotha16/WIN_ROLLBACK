# 17.2.6 - (L1) Ensure 'Audit User Account Management' is set to 'Success and Failure' (Scored)

$unique = auditpol.exe /get /category:*   | select-string "User Account Management" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}
