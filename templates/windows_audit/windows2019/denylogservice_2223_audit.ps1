#   2.2.23 (L1) Ensure 'Deny log on as a service' to include 'Guests' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-32-546'
$output = (Get-content c:\secpol.cfg | select-string "SeDenyServiceLogonRight") |  Measure-Object | %{$_.Count}

if ($output -ne 0) {
	$output1 = (Get-content c:\secpol.cfg | select-string "SeDenyServiceLogonRight").ToString().Split('=')[1].Trim() 2> $null	
	if ([string]$output1 -ne [string]$unique) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
		}
} else {
	write-output "FAILED"
}
rm -force c:\secpol.cfg -confirm:$false 
