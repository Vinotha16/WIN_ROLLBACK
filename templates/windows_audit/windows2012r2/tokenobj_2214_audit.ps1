#   2.2.14 (L1) - Ensure 'Create a token object' is set to 'No One' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$output = (Get-content c:\secpol.cfg | select-string "SeCreateTokenPrivilege") |  Measure-Object | %{$_.Count}

if ($output -eq "1") {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false
