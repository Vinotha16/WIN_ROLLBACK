#   2.2.35 (L1) Ensure 'Lock pages in memory' is set to 'No One' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$output = (Get-content c:\secpol.cfg | select-string "SeLockMemoryPrivilege") |  Measure-Object | %{$_.Count}

if ($output -eq "1") {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false 
