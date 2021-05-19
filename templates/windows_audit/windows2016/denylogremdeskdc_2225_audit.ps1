#  2.2.25 (L1) Ensure 'Deny log on through Remote Desktop Services' is set to 'Guests' (DC only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-32-546'
$output = (Get-content c:\secpol.cfg | select-string "SeDenyRemoteInteractiveLogonRight") |  Measure-Object | %{$_.Count}

if ($output -ne 0) {
	$output1 = (Get-content c:\secpol.cfg | select-string "SeDenyRemoteInteractiveLogonRight").ToString().Split('=')[1].Trim() 2> $null	
	if ([string]$output1 -ne [string]$unique) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
		}
} else {
	write-output "FAILED"
}
rm -force c:\secpol.cfg -confirm:$false 
