# 17.2.4 - (L1) Ensure 'Audit Other Account Management Events' is set to include 'Success' (DC only) (Scored)

$unique = auditpol.exe /get /category:*   | select-string "Other Account Management Events" | Foreach {"$(($_ -split '\s+',6)[5])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}