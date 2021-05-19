#   2.3.10.6 (L1) - Configure 'Network access: Named Pipes that can be accessed anonymously' (DC only) (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = 'MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\NullSessionPipes=7,LSARPC,NETLOGON,SAMR,BROWSER'
$output = Get-content c:\secpol.cfg | Select-String NullSessionPipes
$output1 = (Get-content c:\secpol.cfg | Select-String NullSessionPipes).ToString().Split('=')[1].Trim()
if ($unique -ne $output) {
	write-output "failed $output1"
} else {
	write-output $output1
}
rm -force c:\secpol.cfg -confirm:$false

