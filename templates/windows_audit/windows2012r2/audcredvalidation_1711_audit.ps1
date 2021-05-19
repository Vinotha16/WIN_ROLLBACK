# 17.1.1 (L1) Ensure 'Audit Credential Validation' is set to 'Success and Failure'
$unique = (auditpol /get /category:*   | select-string "Credential Validation" | Foreach {"$(($_ -split '\s+',4)[3])"})
$output = "Success and Failure"
if ([string]$unique -ne [string]$output) {
        write-output "FAILED"
    } else {
        write-output "PASSED"
    }
