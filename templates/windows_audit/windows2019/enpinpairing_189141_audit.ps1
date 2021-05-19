$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Connect -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

#   18.9.14.1 (L1) Ensure 'Require pin for pairing' is set to 'Enabled: First Time' OR 'Enabled: Always' (Scored)



    $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Connect")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Connect" 2> $null | select-string 'RequirePinForPairing' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Connect" | select-string 'RequirePinForPairing').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -ge [int]'0x1' ) {
				Write-Output "PASSED"
			} else {
				Write-Output "FAILED"
				}
							}
	}else {
		Write-Output "FAILED"
	}
}

Catch [System.Management.Automation.ItemNotFoundException]
{
 
  Write-Output "FAILED"
 }
Finally { $ErrorActionPreference = "Continue" }
