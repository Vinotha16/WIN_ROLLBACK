#  17.5.6 - (L1) Ensure 'Audit Special Logon' is set to include 'Success' (Scored)

$unique = auditpol.exe /get /category:*   | select-string "Special Logon" |  Foreach {"$(($_ -split '\s+',4)[3])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}