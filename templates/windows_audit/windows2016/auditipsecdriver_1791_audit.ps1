#  17.9.1 - (L1) Ensure 'Audit IPsec Driver' is set to 'Success and Failure' (Scored)

$unique =  auditpol.exe /get /category:*   | select-string "IPsec Driver" |  Foreach {"$(($_ -split '\s+',4)[3])"}
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}