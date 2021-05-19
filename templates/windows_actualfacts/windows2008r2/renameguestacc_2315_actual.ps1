#   2.3.1.5 (L1) - Configure 'Accounts: Rename guest account' (Scored)
secedit /export /cfg c:\secpol.cfg > $null$output = 'NewGuest'$unique = (Get-content c:\secpol.cfg | select-string 'NewGuestName').ToString().Split('=')[1].Trim().Trim('"')#$failed = (Get-content c:\secpol.cfg | select-string 'NewGuestName')if ($output -ne $unique) {#	$failed = $failed -replace 'NewGuestName = ',''     write-output "failed $unique"} else {	Write-Output $output}rm -force c:\secpol.cfg -confirm:$false 

