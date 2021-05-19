#   2.3.7.9 (L1) - Ensure 'Interactive logon: Smart card removal behavior' is set to 'Lock Workstation' or higher (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = 'MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\ScRemoveOption=1,"0"'
$output = Get-content c:\secpol.cfg | select-string ScRemoveOption

if ([string]$unique -eq [string]$output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false 

