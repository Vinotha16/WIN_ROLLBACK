# 17.2.4 - (L1) Ensure 'Audit Other Account Management Events' is set to include 'Success' (DC only) (Scored)
$failed = (auditpol /get /category:*   | select-string "Other Account Management Events"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Other Account Management Events ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique = auditpol.exe /get /category:*   | select-string "Other Account Management Events" | Foreach {"$(($_ -split '\s+',6)[5])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
	} else {
		write-output $unique
	}