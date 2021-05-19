#   2.3.10.7 (L1) - Configure 'Network access: Named Pipes that can be accessed anonymously' (MS only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = 'MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\NullSessionPipes=7,BROWSER'
$output = Get-content c:\secpol.cfg | Select-String NullSessionPipes

if ($unique -ne $output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false

