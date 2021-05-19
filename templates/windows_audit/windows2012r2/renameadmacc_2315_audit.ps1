#   2.3.1.5 (L1) - Configure 'Accounts: Rename administrator account' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$output = '"NewAdmin"'
$unique = (Get-content c:\secpol.cfg | select-string 'NewAdministratorName').ToString().Split('=')[1].Trim()
if ($output -ne $unique) {
    Write-Output "FAILED"
} else { 
	Write-Output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false 

