#   2.2.36 (L2) - Ensure 'Log on as a batch job' is set to 'Administrators' (DC Only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null 
$unique = '*S-1-5-32-544'
$output = (Get-content c:\secpol.cfg | select-string 'SeBatchLogonRight').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {
   $failed = (Get-content c:\secpol.cfg | select-string 'SeBatchLogonRight').ToString().Split('=')[1].Trim().replace('*', '')
   write-output "failed $failed" 
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false