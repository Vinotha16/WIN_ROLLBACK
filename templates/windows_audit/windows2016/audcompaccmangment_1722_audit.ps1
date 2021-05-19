# 17.2.2 - (L1) Ensure 'Audit Computer Account Management' is set to include 'Success' (DC only) (Scored)

$unique = (auditpol.exe /get /category:*   | select-string "Computer Account Management" | Foreach {"$(($_ -split '\s+',5)[4])"})
$output = "Success"
if ([string]$unique -ne [string]$output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}
	