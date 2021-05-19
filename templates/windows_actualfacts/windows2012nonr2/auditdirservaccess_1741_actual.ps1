# 17.4.1 (L1) Ensure 'Audit Directory Service Access' is set to include 'Failure' (DC only) (Scored) 
$failed = (auditpol /get /category:*   | select-string "Directory Service Access"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Directory Service Access ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique =  auditpol.exe /get /category:*   | select-string "Directory Service Access" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Failure"

if ([string]$unique -ne [string]$output) {
	write-output "failed $failed"
} else {
	write-output $unique
}
