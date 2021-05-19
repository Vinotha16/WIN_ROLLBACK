#   2.3.1.2 (L1) - Ensure 'Accounts: Guest account status' is set to 'Disabled' (MS only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$output = 'No'
$groupname = (Get-content c:\secpol.cfg | select-string 'NewGuestName').ToString().Split('=')[1].Trim().Trim('"')
$unique = (net user $groupname | select-string 'Account active').ToString().Split(' ')[16].Trim()
if ($output -ne $unique) {
    $output = (net user guest | select-string 'Account active' | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace('Account active ', '')})
    $output = $output -replace 'Yes','1'
    Write-Output "failed $output"
} else {
	Write-Output $unique
}
rm -force c:\secpol.cfg -confirm:$false
