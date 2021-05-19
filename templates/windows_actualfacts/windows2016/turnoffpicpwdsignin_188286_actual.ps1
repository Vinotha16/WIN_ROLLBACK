	$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

#  	18.8.28.6 (L1) - Ensure 'Turn off picture password sign-in' is set to 'Enabled' (Scored)

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" 2> $null | select-string 'BlockDomainPicturePassword' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" | select-string 'BlockDomainPicturePassword').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x1' ) {
				Write-Output $unique1
			} else {
				$unique1 = $unique1 -replace '0x',''
			Write-Output $unique1
				}
							}
	}else {
	Write-Output "DELETE"
	}

}

Catch [System.Management.Automation.ItemNotFoundException]
{
 Write-Output "DELETE"
 }
Finally { $ErrorActionPreference = "Continue" }
