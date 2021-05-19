#   2.3.10.8 (L1) - Configure 'Network access: Remotely accessible registry paths' (Scored)

secedit /export /cfg c:\secpol.cfg > $null$unique = '7,System\CurrentControlSet\Control\ProductOptions,System\CurrentControlSet\Control\Server Applications,Software\Microsoft\Windows NT\CurrentVersion'$output = (Get-content c:/secpol.cfg | select-string 'Winreg.*AllowedExactPaths.*Machine').ToString().Split('=')[1].Trim()if ($unique -ne $output) {	write-output "failed $output"} else {	write-output "$output"}rm -force c:\secpol.cfg -confirm:$false

