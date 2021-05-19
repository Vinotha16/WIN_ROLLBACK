#   2.2.16 (L1) - Ensure 'Create permanent shared objects' is set to 'No One' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$output = (Get-content c:\secpol.cfg | select-string "SeCreatePermanentPrivilege") |  Measure-Object | %{$_.Count}

if ($output -eq "1") {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false
