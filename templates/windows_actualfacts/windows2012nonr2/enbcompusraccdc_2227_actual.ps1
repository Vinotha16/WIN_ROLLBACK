#  2.2.27 (L1) Ensure 'Enable computer and user accounts to be trusted for delegation' is set to 'Administrators' (DC only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-32-544'
$output = (Get-content c:\secpol.cfg | select-string "SeEnableDelegationPrivilege") |  Measure-Object | %{$_.Count}
if ($output -ne 0) {
	$output1 = (Get-content c:\secpol.cfg | select-string "SeEnableDelegationPrivilege").ToString().Split('=')[1].Trim() 2> $null	
	if ([string]$output1 -ne [string]$unique) {
        $failed = (Get-content c:\secpol.cfg | select-string "SeEnableDelegationPrivilege").ToString().Split('=')[1].Trim().replace('*', '')
        write-output "failed $failed"
	} else {
		write-output $output1
		}
} else {
   write-output "failed_empty"
}
rm -force c:\secpol.cfg -confirm:$false