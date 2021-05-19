#   2.3.8.1 (L1) Ensure 'Microsoft network client: Digitally sign communications (always)' is set to 'Enabled' (Scored)
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
   $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters")
   $unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" 2> $null | select-string 'RequireSecuritySignature' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" | select-string 'RequireSecuritySignature'| Foreach {"$(($_ -split '\s+',4)[3])"} ) ) {
	if (  ( $unique1 -eq '0x1' ) ) {
                $unique1 = REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" | select-string 'RequireSecuritySignature'| Foreach {"$(($_ -split '\s+',4)[3])"}
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