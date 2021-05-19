# 17.1.1 (L1) Ensure 'Audit Credential Validation' is set to 'Success and Failure'
$failed = (auditpol /get /category:*   | select-string "Credential Validation"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Credential Validation ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique = (auditpol /get /category:*   | select-string "Credential Validation" | Foreach {"$(($_ -split '\s+',4)[3])"})
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
    } else {
	    $unique = $unique -replace 'Success and Failure','success, failure'
        write-output $unique
    }
	
	
	
	
	