#   2.3.1.5 (L1) - Configure 'Accounts: Rename administrator account' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$output = 'NewAdmin'
$unique = (Get-content c:\secpol.cfg | select-string 'NewAdministratorName').ToString().Split('=')[1].Trim().Trim('"')
#$failed = (Get-content c:\secpol.cfg | select-string 'NewAdministratorName')
if ($output -ne $unique) {
#    $failed = $failed -replace 'NewAdministratorName = ','' 
    write-output "failed $unique"
} else { 
	Write-Output $output
}
rm -force c:\secpol.cfg -confirm:$false 

