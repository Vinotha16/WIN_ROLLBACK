#   2.2.28 (L1) Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'No One' (MS only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$output = (Get-content c:\secpol.cfg | select-string "SeEnableDelegationPrivilege") |  Measure-Object | %{$_.Count}
if ($output -eq "1") {
   $failed = (Get-content c:\secpol.cfg | select-string "SeEnableDelegationPrivilege").ToString().Split('=')[1].Trim().replace('*', '')
   write-output "failed $failed"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false