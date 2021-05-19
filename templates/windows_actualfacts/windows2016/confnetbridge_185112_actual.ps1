#  18.5.11.2 (L1) Ensure 'Prohibit installation and configuration of Network  Bridge on your DNS domain network' is set to 'Enabled'

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Network Connections")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Network Connections" 2> $null | select-string 'NC_AllowNetBridge_NLA' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Network Connections" | select-string 'NC_AllowNetBridge_NLA').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x0' ) {
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
	
	

	
