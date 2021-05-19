#   2.3.10.7 (L1) Configure 'Network access: Named Pipes that can be accessed anonymously' (MS only) (Scored)
secedit /export /cfg c:\secpol.cfg > $null
$unique = 'MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\NullSessionPipes=7,BROWSER'
$output = Get-content c:\secpol.cfg | Select-String NullSessionPipes
$output1 = (Get-content c:\secpol.cfg | Select-String NullSessionPipes).ToString().Split('=')[1].Trim()
if (  [string]$output -ne [string]$unique ) {
                write-output "failed $output1"
} else {
        write-output $output1
}
rm -force c:\secpol.cfg -confirm:$false
