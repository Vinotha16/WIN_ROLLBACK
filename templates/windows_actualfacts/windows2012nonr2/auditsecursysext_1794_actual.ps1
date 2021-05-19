#  17.9.4 (L1) Ensure 'Audit Security System Extension' is set to include 'Success' (Scored) 
$failed = (auditpol /get /category:*   | select-string "Security System Extension"  | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace(' Security System Extension ', '').replace('No Auditing', 'none').replace('Success and Failure', 'success, failure')} )
$unique =  auditpol.exe /get /category:*   | select-string "Security System Extension" |  Foreach {"$(($_ -split '\s+',5)[4])"}
$output = "Success"

if ([string]$unique -ne [string]$output) {
	write-output "failed $failed"
} else {
	write-output $unique
}
