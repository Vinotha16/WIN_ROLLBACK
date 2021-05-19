#   2.3.5.1 (L1) - Ensure 'Domain controller: Allow server operators to schedule tasks' is set to 'Disabled' (DC only) (Scored)
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\Lsa -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
   $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa")
   $unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" 2> $null | select-string 'SubmitControl' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" | select-string 'SubmitControl').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x0' ) {
		Write-Output $unique1
	} else {
		Write-Output ""
		}
	}
}else {
	Write-Output ""
}


}
Catch [System.Management.Automation.ItemNotFoundException]
{
  Write-Output ""
 }
Finally { $ErrorActionPreference = "Continue" }