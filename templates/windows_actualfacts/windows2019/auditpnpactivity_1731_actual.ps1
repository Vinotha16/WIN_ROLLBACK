# 17.3.1 - (L1) Ensure 'Audit PNP Activity' is set to include 'Success' (Scored)
$failed = (auditpol /get /category:*   | select-string "Plug and Play Events"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Plug and Play Events ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique =  auditpol.exe /get /category:*   | select-string "Plug and Play Events" |  Foreach {"$(($_ -split '\s+',6)[5])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
	} else {
		write-output $unique
	}

