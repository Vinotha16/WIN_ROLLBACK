# 17.9.3 - (L1) Ensure 'Audit Security State Change' is set to include 'Success' (Scored)
$failed = (auditpol /get /category:*   | select-string "Security State Change"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Security State Change ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique =  auditpol.exe /get /category:*   | select-string "Security State Change" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
	} else {
		write-output $unique
	}