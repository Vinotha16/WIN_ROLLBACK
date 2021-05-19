$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\SearchCompanion -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{


#  	18.8.22.1.8 (L2) - Ensure 'Turn off Search Companion content file updates' is set to 'Enabled' (Scored)

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SearchCompanion")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SearchCompanion" 2> $null | select-string 'DisableContent FileUpdates' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SearchCompanion" | select-string 'DisableContent FileUpdates').ToString().Split('')[13].Trim() ) {
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
