#   2.2.35 (L1) Ensure 'Lock pages in memory' is set to 'No One' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$output = (Get-content c:\secpol.cfg | select-string "SeLockMemoryPrivilege") |  Measure-Object | %{$_.Count}
if ($output -eq "1") {
   $failed = (Get-content c:\secpol.cfg | select-string "SeLockMemoryPrivilege").ToString().Split('=')[1].Trim().replace('*', '')
   write-output "failed $failed"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false