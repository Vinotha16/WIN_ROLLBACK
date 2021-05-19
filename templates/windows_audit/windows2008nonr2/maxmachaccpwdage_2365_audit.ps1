#   2.3.6.5 (L1) - Ensure 'Domain member: Maximum machine account password age' is set to '30 or fewer days, but not 0' (Scored)


	secedit /export /cfg c:\secpol.cfg > $null
	$unique = '4,30'
	$output = (Get-content c:\secpol.cfg | select-string MaximumPasswordAge=).ToString().Split('=')[1].Trim()
	if ($output -eq '4,0') {
		write-output "FAILED"
	} elseif ([int]$unique -lt [int]$output){
		write-output "FAILED"
	} else {
 		write-output "PASSED"
	}
	rm -force c:\secpol.cfg -confirm:$false 