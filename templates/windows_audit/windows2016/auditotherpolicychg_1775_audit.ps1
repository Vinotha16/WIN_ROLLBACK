# 17.7.5 (L1) Ensure 'Audit Other Policy Change Events' is set to include 'Failure' (Scored)

$unique =  auditpol.exe /get /category:*   | select-string "Other Policy Change Events" |  Foreach {"$(($_ -split '\s+',6)[5])"}
$output = "Failure"
if ([string]$unique -ne [string]$output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}