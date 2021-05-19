# 17.7.5 (L1) Ensure 'Audit Other Policy Change Events' is set to include 'Failure' (Scored)
$failed = (auditpol /get /category:*   | select-string "Other Policy Change Events"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Other Policy Change Events ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique =  auditpol.exe /get /category:*   | select-string "Other Policy Change Events" |  Foreach {"$(($_ -split '\s+',6)[5])"}
$output = "Failure"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
	} else {
		write-output $unique
	}