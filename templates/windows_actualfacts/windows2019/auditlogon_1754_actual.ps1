# 17.5.4 - (L1) Ensure 'Audit Logon' is set to 'Success and Failure' (Scored)
$failed = (auditpol /get /category:*   | select-string "Logon"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Logon ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique =  auditpol.exe /get /category:*   | select-string "  Logon   "   | Foreach {"$(($_ -split '\s+',3)[2])"}
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
	} else {
	    $unique = $unique -replace 'Success and Failure','success, failure'
		write-output $unique
	}