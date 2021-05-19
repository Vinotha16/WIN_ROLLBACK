# 17.4.2 - (L1) Ensure 'Audit Directory Service Changes' is set to include 'Failure' (DC only) (Scored)
 
$unique =  auditpol.exe /get /category:*   | select-string "Directory Service Changes" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}
