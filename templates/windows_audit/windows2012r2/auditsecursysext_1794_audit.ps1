#  17.9.4 (L1) Ensure 'Audit Security System Extension' is set to include 'Success' (Scored) 

$unique =  auditpol.exe /get /category:*   | select-string "Security System Extension" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success"

if ([string]$unique -ne [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
