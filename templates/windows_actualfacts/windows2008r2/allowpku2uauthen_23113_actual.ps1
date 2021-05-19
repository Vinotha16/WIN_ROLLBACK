#   2.3.11.3 (L1) - Ensure 'Network Security: Allow PKU2U authentication requests to this computer to use online identities' is set to 'Disabled' (Scored)
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\pku2u -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

    $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\pku2u")
    $unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\pku2u" 2> $null | select-string 'AllowOnlineID' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\pku2u" | select-string 'AllowOnlineID').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x0' )  {
		Write-Output $unique1
	} else {
		Write-Output "failed $unique1"
		}
	}
}else {
	Write-Output "failed $unique1"
}


}
Catch [System.Management.Automation.ItemNotFoundException]
{
  Write-Output ""
 }
Finally { $ErrorActionPreference = "Continue" }