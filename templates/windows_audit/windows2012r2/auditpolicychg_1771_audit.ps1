# 17.7.1 (L1) Ensure 'Audit Audit Policy Change' is set to include 'Success' (Scored) 

$unique =  auditpol.exe /get /category:*   | select-string "Audit Policy Change" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
