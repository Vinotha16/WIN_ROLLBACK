#   18.3.7(L1) -  Ensure 'NetBT NodeType configuration' is set to 'Enabled: Pnode (recommended)' 
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\NetBT\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NetBT\Parameters")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NetBT\Parameters" 2> $null | select-string 'NodeType' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NetBT\Parameters" | select-string 'NodeType').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x2' ) {
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


