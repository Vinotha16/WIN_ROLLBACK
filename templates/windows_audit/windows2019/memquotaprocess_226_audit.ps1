#   2.2.6 (L1) Ensure 'Adjust memory quotas for a process' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE' (Scored)
        secedit /export /cfg c:\secpol.cfg > $null
        $unique = '*S-1-5-19,*S-1-5-20,*S-1-5-32-544'
        $output = (Get-content c:/secpol.cfg | select-string 'SeIncreaseQuotaPrivilege').ToString().Split('=')[1].Trim()
        if ($unique -ne $output) {
                write-output "FAILED"
        } else {
                write-output "PASSED"
        }
        rm -force c:\secpol.cfg -confirm:$false
