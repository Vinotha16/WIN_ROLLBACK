# 17.2.3 - (L1) Ensure 'Audit Distribution Group Management' is set to include 'Success' (DC only) (Scored)

$unique = auditpol.exe /get /category:*   | select-string "Distribution Group Management" | Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}