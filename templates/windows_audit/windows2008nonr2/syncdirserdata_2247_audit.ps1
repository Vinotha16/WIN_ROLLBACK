#   2.2.47 (L1) Ensure 'Synchronize directory service data' is set to 'No One' (DC only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$output = (Get-content c:\secpol.cfg | select-string "SeSyncAgentPrivilege") |  Measure-Object | %{$_.Count}

if ($output -eq "1") {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false 
