# 17.5.3 (L1) Ensure 'Audit Logon' is set to 'Success and Failure' (Scored)

$unique =  auditpol.exe /get /category:*   | select-string "  Logon   "   | Foreach {"$(($_ -split '\s+',3)[2])"}
$output = "Success and Failure"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
