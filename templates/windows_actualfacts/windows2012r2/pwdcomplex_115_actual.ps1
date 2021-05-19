
# 1.1.5 (L1) - Ensure 'Password must meet complexity requirements' is set to 'Enabled' (Scored)

	secedit /export /cfg c:\secpol.cfg > $null
	$unique = '1'
	$output = (Get-content c:\secpol.cfg | select-string PasswordComplexity).ToString().Split('=')[1].Trim()
	if ($unique -ne $output) {
	    $output = (Get-content c:\secpol.cfg | select-string PasswordComplexity | Foreach {"$(($_ -split '\s+'))"} | ForEach-Object {$_.replace('PasswordComplexity = ', '')})
	    Write-Output "failed $output"
	} else {
		write-output $unique
	}
	rm -force c:\secpol.cfg -confirm:$false