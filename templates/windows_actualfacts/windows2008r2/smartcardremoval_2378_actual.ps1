#   2.3.7.8 (L1) - Ensure 'Interactive logon: Smart card removal behavior' is set to 'Lock Workstation' or higher (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = 'MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\ScRemoveOption=1,"0"'
$output = (Get-content c:\secpol.cfg | select-string ScRemoveOption)
$failed = (Get-content c:\secpol.cfg | select-string ScRemoveOption).ToString().Split('=')[1].Trim()
if ([string]$unique -eq [string]$output) {
        $failed = $failed -replace '"0"' , '0'
	write-output "failed $failed"
} else {
        $output = $output -replace '"1"' , '1'
	write-output $output
}
rm -force c:\secpol.cfg -confirm:$false 