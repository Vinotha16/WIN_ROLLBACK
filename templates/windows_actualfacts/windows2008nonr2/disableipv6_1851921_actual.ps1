#  	18.5.19.2.1 (L2) - Disable IPv6 (Ensure TCPIP6 Parameter 'DisabledComponents' is set to '0xff (255)') 

$value = "0xff"
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters")	
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" 2> $null | select-string 'DisabledComponents' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" | select-string 'DisabledComponents') | Foreach {"$(($_ -split '\s+',4)[3])"} ) {
	if ( $unique1 -eq $value ) {
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

