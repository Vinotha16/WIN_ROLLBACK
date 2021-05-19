# 17.7.4 (L1) Ensure 'Audit MPSSVC Rule-Level Policy Change' is set to 'Success and Failure' (Scored)
$failed = (auditpol /get /category:*   | select-string "MPSSVC Rule-Level Policy Change"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' MPSSVC Rule-Level Policy Change ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique = (auditpol.exe /get /category:*   | select-string "MPSSVC Rule-Level Policy Change" | Foreach {"$(($_ -split '\s+',6)[5])"})
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
        write-output "failed $failed"
} else {
       $unique = $unique -replace 'Success and Failure','success, failure'
        write-output $unique
	}
