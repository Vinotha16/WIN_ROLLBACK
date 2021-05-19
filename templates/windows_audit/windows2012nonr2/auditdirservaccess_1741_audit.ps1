# 17.4.1 (L1) Ensure 'Audit Directory Service Access' is set to include 'Failure' (DC only) (Scored) 

$unique =  auditpol.exe /get /category:*   | select-string "Directory Service Access" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Failure"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
