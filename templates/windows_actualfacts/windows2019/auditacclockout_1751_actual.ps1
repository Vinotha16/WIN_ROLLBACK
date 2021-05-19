# 17.5.1 - (L1) Ensure 'Audit Account Lockout' is set to include 'Failure' (Scored)
$failed = (auditpol /get /category:*   | select-string "Account Lockout"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Account Lockout ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique = auditpol.exe /get /category:*   | select-string "Account Lockout" |  Foreach {"$(($_ -split '\s+',4)[3])"}
$output = "Failure"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
	} else {
		write-output $unique
	}