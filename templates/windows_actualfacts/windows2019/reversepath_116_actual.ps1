#   1.1.6 (L1) Ensure 'Store passwords using reversible encryption' is set to 'Disabled' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '0'
$output = (Get-content c:/secpol.cfg | select-string 'ClearTextPassword').ToString().Split('=')[1].Trim()

if ($output -ne $unique) {
    $output = (Get-content c:/secpol.cfg | select-string 'ClearTextPassword' | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace('ClearTextPassword = ', '')})
    Write-Output "failed $output"
} else {
	write-output $unique
}
rm -force c:\secpol.cfg -confirm:$false