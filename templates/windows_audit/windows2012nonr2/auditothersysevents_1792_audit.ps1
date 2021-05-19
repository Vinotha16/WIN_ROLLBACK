#  17.9.2 (L1) Ensure 'Audit Other System Events' is set to 'Success and Failure' (Scored)

$unique =  auditpol.exe /get /category:*   | select-string "Other System Events" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success and Failure"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
