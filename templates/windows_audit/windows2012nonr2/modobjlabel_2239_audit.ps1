#   2.2.39 (L1) Ensure 'Modify an object label' is set to 'No One' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$output = (Get-content c:\secpol.cfg | select-string "SeRelabelPrivilege") |  Measure-Object | %{$_.Count}

if ($output -eq "1") {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false 
