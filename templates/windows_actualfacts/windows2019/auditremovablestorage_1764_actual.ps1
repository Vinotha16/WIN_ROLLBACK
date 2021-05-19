#  17.6.4 - (L1) Ensure 'Audit Removable Storage' is set to 'Success and Failure' (Scored)
$failed = (auditpol /get /category:*   | select-string "Removable Storage"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Removable Storage ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique = auditpol.exe /get /category:*   | select-string "Removable Storage" |  Foreach {"$(($_ -split '\s+',4)[3])"}
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
	} else {
		write-output $unique
	}