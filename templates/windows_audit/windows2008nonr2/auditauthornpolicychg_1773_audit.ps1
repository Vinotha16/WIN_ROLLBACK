#  17.7.3 (L1) Ensure 'Audit Authorization Policy Change' is set to include 'Success' (Scored) 

$unique =  auditpol.exe /get /category:*   | select-string "Authorization Policy Change" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
