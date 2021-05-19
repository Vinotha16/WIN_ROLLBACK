# 17.4.2 (L1) Ensure 'Audit Directory Service Changes' is set to include 'Success' (DC only) (Scored) 
$failed = (auditpol /get /category:*   | select-string "Directory Service Changes"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Directory Service Changes ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique =  auditpol.exe /get /category:*   | select-string "Directory Service Changes" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success"

if ([string]$unique -ne [string]$output) {
	write-output "failed $failed"
} else {
	write-output $unique
}
