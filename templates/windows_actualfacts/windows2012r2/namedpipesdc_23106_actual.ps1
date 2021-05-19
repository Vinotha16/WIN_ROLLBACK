#   2.3.10.6 (L1) - Configure 'Network access: Named Pipes that can be accessed anonymously' (DC only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = 'MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\NullSessionPipes=7,LSARPC,NETLOGON,SAMR,BROWSER'
$output = Get-content c:\secpol.cfg | Select-String NullSessionPipes

if ($unique -ne $output) {
	write-output ""
} else {
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false
