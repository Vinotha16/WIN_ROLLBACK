#   2.3.1.1 (L1) - Ensure 'Accounts: Administrator account status' is set to 'Disabled' (MS only) (Scored)

$output = 'No'
secedit /export /cfg c:\secpol.cfg > $null
$adminame = (Get-content c:\secpol.cfg | select-string 'NewAdministratorName').ToString().Split('=')[1].Trim().Trim('"')
$unique = (net user $adminame  | select-string 'Account active').ToString().Split(' ')[16].Trim()
if ($output -ne $unique) {
    $output = (net user administrator | select-string 'Account active' | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace('Account active ', '')})
    $output = $output -replace 'Yes','1'
    write-output "failed $output"
} else {
	Write-Output $output
}
rm -force c:\secpol.cfg -confirm:$false
