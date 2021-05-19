#  17.9.1 (L1) Ensure 'Audit IPsec Driver' is set to 'Success and Failure' (Scored)
$failed = (auditpol /get /category:*   | select-string "IPsec Driver"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' IPsec Driver ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique =  auditpol.exe /get /category:*   | select-string "IPsec Driver" |  Foreach {"$(($_ -split '\s+',4)[3])"}
$output = "Success and Failure"

if ([string]$unique -ne [string]$output) {
	write-output "failed $failed"
} else {
        $unique = $unique -replace 'Success and Failure','success, failure'
	write-output $unique
}
