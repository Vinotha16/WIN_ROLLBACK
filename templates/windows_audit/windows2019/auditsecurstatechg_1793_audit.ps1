# 17.9.3 - (L1) Ensure 'Audit Security State Change' is set to include 'Success' (Scored)

$unique =  auditpol.exe /get /category:*   | select-string "Security State Change" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}