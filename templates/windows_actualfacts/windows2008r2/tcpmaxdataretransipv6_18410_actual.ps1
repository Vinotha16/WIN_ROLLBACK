#   18.4.10 (L2) - Ensure 'MSS: (TcpMaxDataRetransmissions IPv6) How many times unacknowledged data is retransmitted' is set to 'Enabled: 3'

$output1 = '0x3'
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
 $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" 2> $null | select-string 'TcpMaxDataRetransmissions' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" | select-string 'TcpMaxDataRetransmissions').ToString().Split('')[12].Trim() ) {
	if ( $unique1 -eq $output1 ) {
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


