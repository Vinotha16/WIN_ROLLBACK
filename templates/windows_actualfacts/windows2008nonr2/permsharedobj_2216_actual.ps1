#   2.2.16 (L1) - Ensure 'Create permanent shared objects' is set to 'No One' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$output = (Get-content c:\secpol.cfg | select-string "SeCreatePermanentPrivilege") |  Measure-Object | %{$_.Count}
if ($output -eq "1") {
   $failed = (Get-content c:\secpol.cfg | select-string "SeCreatePermanentPrivilege").ToString().Split('=')[1].Trim().replace('*', '')
   write-output "failed $failed"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false