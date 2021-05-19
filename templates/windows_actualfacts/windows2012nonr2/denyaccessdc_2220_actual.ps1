#   2.2.20 (L1) - Ensure 'Deny access to this computer from the network' is set to 'Guests' (DC only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-32-546'
$output = (Get-content c:\secpol.cfg | select-string "SeDenyNetworkLogonRight") |  Measure-Object | %{$_.Count}
if ($output -eq 1) {
	$output1 = (Get-content c:\secpol.cfg | select-string "SeDenyNetworkLogonRight").ToString().Split('=')[1].Trim() 2> $null	
	if ([string]$output1 -ne [string]$unique) {
   $failed = (Get-content c:\secpol.cfg | select-string "SeDenyNetworkLogonRight").ToString().Split('=')[1].Trim().replace('*', '')
   write-output "failed $failed"
	} else {
		write-output $output1
	}
} else {
   write-output "failed_empty"
}
rm -force c:\secpol.cfg -confirm:$false