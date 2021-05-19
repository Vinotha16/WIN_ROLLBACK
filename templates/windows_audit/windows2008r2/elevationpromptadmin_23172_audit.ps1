#   2.3.17.2 (L1) - Ensure 'User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode' is set to 'Prompt for consent on the secure desktop' (Scored)

secedit /export /cfg c:\secpol.cfg > $null
$unique = '4,2'
$output = (Get-content c:\secpol.cfg | Select-String 'ConsentPromptBehaviorAdmin').ToString().Split('=')[1].Trim()

if ($unique -ne $output) {
	write-output "FAILED"
} else {
	write-output "PASSED"
}
rm -force c:\secpol.cfg -confirm:$false

