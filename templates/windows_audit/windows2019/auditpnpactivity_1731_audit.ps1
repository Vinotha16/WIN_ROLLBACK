# 17.3.1 - (L1) Ensure 'Audit PNP Activity' is set to include 'Success' (Scored)

$unique =  auditpol.exe /get /category:*   | select-string "Plug and Play Events" |  Foreach {"$(($_ -split '\s+',6)[5])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}


