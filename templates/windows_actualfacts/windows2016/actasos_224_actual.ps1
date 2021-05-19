#   2.2.4 (L1) Ensure 'Act as part of the operating system' is set to 'No One' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$output = (Get-content c:\secpol.cfg | select-string SeTcbPrivilege) |  Measure-Object | %{$_.Count}
if ($output -eq "1") {
$failed = (Get-content c:\secpol.cfg | select-string SeTcbPrivilege).ToString().Split('=')[1].Trim().replace('*', '')
    write-output "failed $failed"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false