#   2.3.7.1 (L1) - Ensure 'Interactive logon: Do not display last user name' is set to 'Enabled' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,1'
$output = (Get-content c:\secpol.cfg | select-string 'DontDisplayLastUserName').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {    
	write-output "failed $output"
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false 

