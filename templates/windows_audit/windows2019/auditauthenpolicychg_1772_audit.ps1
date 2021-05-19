#  17.7.2 - (L1) Ensure 'Audit Authentication Policy Change' is set to 'Success' (Scored)

$unique =  auditpol.exe /get /category:*   | select-string "Authentication Policy Change" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}