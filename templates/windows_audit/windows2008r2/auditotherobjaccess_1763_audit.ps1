# 17.6.3 (L1) Ensure 'Audit Other Object Access Events' is set to 'Success and Failure' (Scored) 

$unique =  auditpol.exe /get /category:*   | select-string "Other Object Access Events" |  Foreach {"$(($_ -split '\s+',6)[5])"}
$output = "Success and Failure"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
