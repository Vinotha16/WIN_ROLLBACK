#   2.2.39 (L1) Ensure 'Modify an object label' is set to 'No One' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$output = (Get-content c:\secpol.cfg | select-string "SeRelabelPrivilege") |  Measure-Object | %{$_.Count}
if ($output -eq "1") {
   $failed = (Get-content c:\secpol.cfg | select-string "SeRelabelPrivilege").ToString().Split('=')[1].Trim().replace('*', '')
   write-output "failed $failed"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false