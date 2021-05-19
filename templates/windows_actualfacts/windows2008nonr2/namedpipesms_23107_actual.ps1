#  2.3.10.7 (L1) Configure 'Network access: Named Pipes that can be accessed anonymously' (MS only) (Scored)
secedit /export /cfg c:\secpol.cfg > $null
$unique = 'MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\NullSessionPipes=7,BROWSER'
$output = Get-content c:\secpol.cfg | Select-String NullSessionPipes
if ($unique -ne $output) {
	   $output = (Get-content c:\secpol.cfg | select-string "NullSessionPipes").ToString().Split('=')[1].Trim()
        write-output $output
} else {
	   $output = (Get-content c:\secpol.cfg | select-string "NullSessionPipes").ToString().Split('=')[1].Trim()
        write-output $output
}
rm -force c:\secpol.cfg -confirm:$false

