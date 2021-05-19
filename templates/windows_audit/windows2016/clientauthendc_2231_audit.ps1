#   2.2.31 (L1) Ensure 'Impersonate a client after authentication' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE' (DC only) (Scored)^M

secedit /export /cfg c:\secpol.cfg > $null
$unique = '*S-1-5-19,*S-1-5-20,*S-1-5-32-544,*S-1-5-6'
$output = (Get-content c:\secpol.cfg | select-string 'SeImpersonatePrivilege').ToString().Split('=')[1].Trim()
if ($unique -ne $output) {
        write-output "FAILED"
} else {
        write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false
