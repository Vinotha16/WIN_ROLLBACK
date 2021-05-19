$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\EMET\SysSettings' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

#   18.9.24.6 (L1) Ensure 'System ASLR' is set to 'Enabled: Application OptIn' (Scored)


	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings" 2> $null | select-string 'ASLR' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\SysSettings" | select-string 'ASLR').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x3' ) {
	               Write-Output $unique1
			} else {
				Write-Output ""
				}
							}
	}else {
			   $unique1 = $unique1 -replace '0x',''
			Write-Output $unique1
	}

}
Catch [System.Management.Automation.ItemNotFoundException]
{
 
  Write-Output "DELETE"
 }
Finally { $ErrorActionPreference = "Continue" }
