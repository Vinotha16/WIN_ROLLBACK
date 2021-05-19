$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\EMET\Defaults\IE -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

#   18.9.24.3 (L1) Ensure 'Default Protections for Internet Explorer' is set to 'Enabled' (Scored)


	
	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\Defaults\IE")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\Defaults\IE" 2> $null | select-string -pattern  '\.exe' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\Defaults\IE" | select-string -pattern  '\.exe' | select-string -pattern '\+EAF'  |  Measure-Object | %{$_.Count} ) ) {
			if ( [int]$unique1 -eq [int]'1' ) {
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



	
	



