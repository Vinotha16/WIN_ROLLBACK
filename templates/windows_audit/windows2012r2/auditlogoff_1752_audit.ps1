# 17.5.2 (L1) Ensure 'Audit Logoff' is set to include 'Success' (Scored) 

$unique =  auditpol.exe /get /category:*   | select-string "  Logoff   "   | Foreach {"$(($_ -split '\s+',3)[2])"}
$output = "Success"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
